namespace dziennik.Models
{
    public class Student
    {
        public int Id { get; set; }
        public int PersonId { get; set; }
        public int ClassId { get; set; }

        public Person Person { get; set; }
        public Class Class { get; set; }
    }
}
