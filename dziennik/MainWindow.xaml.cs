using dziennik.ViewModels;
using System.Windows;

namespace dziennik
{
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            DataContext = new MainViewModel();
        }
    }
}