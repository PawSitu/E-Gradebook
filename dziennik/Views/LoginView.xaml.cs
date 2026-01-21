using dziennik.ViewModels;
using System;
using System.Windows;
using System.Windows.Controls;

namespace dziennik.Views
{
    public partial class LoginView : UserControl
    {
        public LoginView()
        {
            InitializeComponent();
            Loaded += LoginView_Loaded;
        }

        private void LoginView_Loaded(object sender, RoutedEventArgs e)
        {
            if (DataContext is LoginViewModel viewModel)
            {
                passwordBox.PasswordChanged += (s, args) =>
                {
                    if (DataContext is LoginViewModel vm)
                    {
                        vm.Password = passwordBox.Password;
                    }
                };
            }
        }
    }
}