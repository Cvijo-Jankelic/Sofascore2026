import Foundation
import SQLite3

final class DatabaseManager {
    static let shared = DatabaseManager()
    private var db: OpaquePointer?
    private let transient = unsafeBitCast(-1, to: sqlite3_destructor_type.self)

    private init() {
        let path = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("sofascore.sqlite").path
        sqlite3_open(path, &db)
        createTables()
    }

    private func createTables() {
        let sql = """
        CREATE TABLE IF NOT EXISTS leagues (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            country_name TEXT,
            logo_url TEXT
        );
        CREATE TABLE IF NOT EXISTS events (
            id INTEGER PRIMARY KEY,
            home_team_name TEXT,
            away_team_name TEXT,
            start_timestamp INTEGER,
            status TEXT,
            league_id INTEGER,
            home_score INTEGER,
            away_score INTEGER,
            sport TEXT
        );
        """
        sqlite3_exec(db, sql, nil, nil, nil)
    }

    func saveLeague(_ league: APILeague) {
        let sql = "INSERT OR IGNORE INTO leagues (id, name, country_name, logo_url) VALUES (?, ?, ?, ?);"
        var stmt: OpaquePointer?
        guard sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK else { return }
        sqlite3_bind_int(stmt, 1, Int32(league.id))
        sqlite3_bind_text(stmt, 2, league.name, -1, transient)
        sqlite3_bind_text(stmt, 3, league.country?.name ?? "", -1, transient)
        sqlite3_bind_text(stmt, 4, league.logoUrl, -1, transient)
        sqlite3_step(stmt)
        sqlite3_finalize(stmt)
    }

    func saveEvent(_ event: APIEvent, sport: String) {
        let sql = """
        INSERT OR IGNORE INTO events
        (id, home_team_name, away_team_name, start_timestamp, status, league_id, home_score, away_score, sport)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);
        """
        var stmt: OpaquePointer?
        guard sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK else { return }
        sqlite3_bind_int(stmt, 1, Int32(event.id))
        sqlite3_bind_text(stmt, 2, event.homeTeam.name, -1, transient)
        sqlite3_bind_text(stmt, 3, event.awayTeam.name, -1, transient)
        sqlite3_bind_int(stmt, 4, Int32(event.startTimestamp))
        sqlite3_bind_text(stmt, 5, event.status.rawValue, -1, transient)
        if let leagueId = event.league?.id {
            sqlite3_bind_int(stmt, 6, Int32(leagueId))
        } else {
            sqlite3_bind_null(stmt, 6)
        }
        if let homeScore = event.homeScore {
            sqlite3_bind_int(stmt, 7, Int32(homeScore))
        } else {
            sqlite3_bind_null(stmt, 7)
        }
        if let awayScore = event.awayScore {
            sqlite3_bind_int(stmt, 8, Int32(awayScore))
        } else {
            sqlite3_bind_null(stmt, 8)
        }
        sqlite3_bind_text(stmt, 9, sport, -1, transient)
        sqlite3_step(stmt)
        sqlite3_finalize(stmt)
    }

    func eventCount() -> Int {
        var stmt: OpaquePointer?
        guard sqlite3_prepare_v2(db, "SELECT COUNT(*) FROM events;", -1, &stmt, nil) == SQLITE_OK else { return 0 }
        defer { sqlite3_finalize(stmt) }
        return sqlite3_step(stmt) == SQLITE_ROW ? Int(sqlite3_column_int(stmt, 0)) : 0
    }

    func leagueCount() -> Int {
        var stmt: OpaquePointer?
        guard sqlite3_prepare_v2(db, "SELECT COUNT(*) FROM leagues;", -1, &stmt, nil) == SQLITE_OK else { return 0 }
        defer { sqlite3_finalize(stmt) }
        return sqlite3_step(stmt) == SQLITE_ROW ? Int(sqlite3_column_int(stmt, 0)) : 0
    }

    func deleteAll() {
        sqlite3_exec(db, "DELETE FROM events; DELETE FROM leagues;", nil, nil, nil)
    }
}
