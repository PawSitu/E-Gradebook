namespace dziennik.Services
{
    public interface IUserService
    {
        UserService.LoginResult LoginUser(string login, string password);
    }
}