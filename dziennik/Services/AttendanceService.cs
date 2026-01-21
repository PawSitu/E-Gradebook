using dziennik.Models;
using dziennik.ViewModels;
using System.Data.SQLite;

namespace dziennik.Services
{
    public class AttendanceService : DatabaseService 
    {
        
        public async Task<List<AttendanceLesson>> GetStudentAttendances(int studentId) 
        {
            var attendanceList = new List<AttendanceLesson>(); 

            await Task.Run(() =>
            {
                using var connection = ConnectDatabase();
                connection.Open();  

                var sqlCommand = new SQLiteCommand( 
                    @"SELECT f.Id, f.Data, f.Status, f.UczenId, f.ZajeciaId,
                    p.Id as PrzedmiotId, p.Nazwa as PrzedmiotNazwa
                    FROM Frekwencja f
                    JOIN Zajecia z ON f.ZajeciaId = z.Id
                    JOIN Przedmiot p ON z.PrzedmiotId = p.Id
                    WHERE f.UczenId = @UczenId
                    ORDER BY f.Data DESC", connection); 
                sqlCommand.Parameters.AddWithValue("@UczenId", studentId); 

                using var reader = sqlCommand.ExecuteReader(); 

                while (reader.Read())
                {
                    var status = Convert.ToInt32(reader["Status"]); 
                    attendanceList.Add(new AttendanceLesson
                    {
                        Date = Convert.ToDateTime(reader["Data"]),
                        Subject = reader["PrzedmiotNazwa"].ToString(), 
                        Status = AttendanceLesson.GetStatusName(status), 
                        StatusColor = AttendanceLesson.GetStatusColor(status) 
                    });
                }
            });

            return attendanceList;
        }      
        public async Task<List<Attendance>> GetStudentAttendancesBySubject(int studentId, int subjectId) 
        {
            var attendanceList = new List<Attendance>();

            await Task.Run(() =>
            {
                using var connection = ConnectDatabase();
                connection.Open();

                var sqlCommand = new SQLiteCommand(
                    @"SELECT f.Id, f.Data, f.Status, f.UczenId, f.ZajeciaId
                    FROM Frekwencja f
                    JOIN Zajecia z ON f.ZajeciaId = z.Id
                    WHERE f.UczenId = @UczenId
                    AND z.PrzedmiotId = @PrzedmiotId
                    ORDER BY f.Data DESC", connection);
                sqlCommand.Parameters.AddWithValue("@UczenId", studentId);
                sqlCommand.Parameters.AddWithValue("@PrzedmiotId", subjectId);

                using var reader = sqlCommand.ExecuteReader();
                while (reader.Read())
                {
                    attendanceList.Add(new Attendance
                    {
                        Id = Convert.ToInt32(reader["Id"]),
                        Date = Convert.ToDateTime(reader["Data"]),
                        Status = Convert.ToInt32(reader["Status"]),
                        StudentId = Convert.ToInt32(reader["UczenId"]),
                        LessonId = Convert.ToInt32(reader["ZajeciaId"])
                    });
                }
            });

            return attendanceList;
        }
        public async Task AddAttendance(Attendance attendance) 
        {
            await Task.Run(() =>
            {
                using var connection = ConnectDatabase();
                connection.Open();

                var sqlCommand = new SQLiteCommand(
                    @"INSERT INTO Frekwencja (Data, Status, UczenId, ZajeciaId) 
                    VALUES (@Data, @Status, @UczenId, @ZajeciaId)", connection);
                sqlCommand.Parameters.AddWithValue("@Data", attendance.Date); 
                sqlCommand.Parameters.AddWithValue("@Status", attendance.Status); 
                sqlCommand.Parameters.AddWithValue("@UczenId", attendance.StudentId); 
                sqlCommand.Parameters.AddWithValue("@ZajeciaId", attendance.LessonId); 

                sqlCommand.ExecuteNonQuery(); 
            });
        }
        public async Task DeleteAttendance(int attendanceId)
        {
            await Task.Run(() =>
            {
                using var connection = ConnectDatabase();
                connection.Open();

                var sqlCommand = new SQLiteCommand("DELETE FROM Frekwencja WHERE Id = @Id", connection);
                sqlCommand.Parameters.AddWithValue("@Id", attendanceId);

                sqlCommand.ExecuteNonQuery();
            });
        }
        public async Task UpdateAttendance(Attendance attendance)
        {
            await Task.Run(() =>
            {
                using var connection = ConnectDatabase();
                connection.Open();

                var sqlCommand = new SQLiteCommand(
                    @"UPDATE Frekwencja 
                    SET Status = @Status 
                    WHERE Id = @Id", connection);
                sqlCommand.Parameters.AddWithValue("@Status", attendance.Status);
                sqlCommand.Parameters.AddWithValue("@Id", attendance.Id);

                sqlCommand.ExecuteNonQuery();
            });
        }
        public async Task<Dictionary<string, int>> GetAttendanceStatistics(int studentId)
        {
            var statistics = new Dictionary<string, int>
            {
                { "Present", 0 },
                { "Absent", 0 },
                { "Late", 0 }
            };

            await Task.Run(() =>
            {
                using var connection = ConnectDatabase();
                connection.Open();

                var sqlCommand = new SQLiteCommand(
                    @"SELECT Status, COUNT(*) as Count
                    FROM Frekwencja
                    WHERE UczenId = @UczenId
                    GROUP BY Status", connection);
                sqlCommand.Parameters.AddWithValue("@UczenId", studentId);

                using var reader = sqlCommand.ExecuteReader();
                while (reader.Read())
                {
                    var status = Convert.ToInt32(reader["Status"]);
                    var count = Convert.ToInt32(reader["Count"]);

                    switch (status) 
                    {
                        case 1:
                            statistics["Present"] = count;
                            break;
                        case 2:
                            statistics["Absent"] = count;
                            break;
                        case 3:
                            statistics["Late"] = count;
                            break;
                    }
                }
            });

            return statistics;
        }
    }
}
