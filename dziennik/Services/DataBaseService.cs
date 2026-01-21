using System.Data.SQLite;
using System.IO;

namespace dziennik.Services
{
    public class DatabaseService  
    {
        private readonly string _databaseLink;

        public DatabaseService()
        {
            string filePath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Data", "dziennik.db"); 
            _databaseLink = $"Data Source={filePath};Version=3;"; 
        }

        protected SQLiteConnection ConnectDatabase() 
        {
            return new SQLiteConnection(_databaseLink); 
        }
    }
}