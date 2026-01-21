namespace dziennik.Models
{
    public class Teacher
    {
        public int Id { get; set; }
        public int PersonId { get; set; }

        public Person Person { get; set; }
    }
}
