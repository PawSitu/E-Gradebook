namespace dziennik.Models
{
    public class Schedule
    {
        public int Id { get; set; }
        public int ClassId { get; set; }
        public int LessonId { get; set; }
        public string DayOfWeek { get; set; }
        public string Time { get; set; }

        public Class Class { get; set; }
        public Lesson Lesson { get; set; }
    }
}
