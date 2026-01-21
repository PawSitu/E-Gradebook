using dziennik.Models;
using dziennik.Services;
using System.Windows.Input;
using System;
using CommunityToolkit.Mvvm.Input;

namespace dziennik.ViewModels
{
    public class LoginViewModel : BaseViewModel
    {
        private readonly MainViewModel _mainViewModel; 
        private readonly IUserService _userService;
        private string _login = string.Empty; 
        private string _password = string.Empty;
        private string _errorMessage = string.Empty;

        public LoginViewModel(MainViewModel mainViewModel) 
        {
            _mainViewModel = mainViewModel;
            _userService = new UserService(); 
            LoginCommand = new RelayCommand(Login, CanLogin);
        }

        #region Methods
        private bool CanLogin()
        {
            return !string.IsNullOrWhiteSpace(LoginName) && !string.IsNullOrWhiteSpace(Password);
        }

        private void Login()
        {
            try
            {
                var result = _userService.LoginUser(LoginName, Password);
                if (result.IsSuccessful)
                {
                    _mainViewModel.LoggedInUser = result.Person;

                    if (result.Student != null)
                    {
                        _mainViewModel.NavigateToStudentPanel(result.Student);
                    }
                    else if (result.Teacher != null)
                    {
                        _mainViewModel.NavigateToTeacherPanel(result.Teacher);
                    }
                   /* else if(result.Admin != null)
                    {
                        _mainViewModel.NavigateToAdminPanel(result.Admin);
                    }*/
                }
                else
                {
                    ErrorMessage = result.Message;
                }
            }
            catch (Exception ex)
            {
                ErrorMessage = $"Wyst¹pi³ b³¹d: {ex.Message}";
            }
        }
        #endregion
        #region Getters/Setters
        public string LoginName
        {
            get => _login;
            set
            {
                SetProperty(ref _login, value);
                (LoginCommand as RelayCommand)?.RaiseCanExecuteChanged();
            }
        }

        public string Password
        {
            get => _password;
            set
            {
                SetProperty(ref _password, value);
                (LoginCommand as RelayCommand)?.RaiseCanExecuteChanged();
            }
        }

        public string ErrorMessage
        {
            get => _errorMessage;
            set => SetProperty(ref _errorMessage, value);
        }
        #endregion
        #region Commands
        public ICommand LoginCommand { get; }
        #endregion
    }
}
