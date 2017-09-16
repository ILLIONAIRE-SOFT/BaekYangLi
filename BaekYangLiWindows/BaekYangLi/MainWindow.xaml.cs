using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Device.Location;
using System.Windows.Shapes;
using System.Net;
using System.IO;
using Newtonsoft.Json.Linq;

namespace BaekYangLi
{
    /// <summary>
    /// MainWindow.xaml에 대한 상호 작용 논리
    /// </summary>
    public partial class MainWindow : Window
    {
       
        public MainWindow()
        {
            InitializeComponent();
           
        }


        private void BtnClick(object sender, RoutedEventArgs e)
        {
            if (sender == OneTouchBtn)
                InsideFrame.Navigate(new OneTouchPage());
            else if (sender == MapBtn)
                InsideFrame.Navigate(new MapPage());
            else
                InsideFrame.Navigate(new Page());
        }
    }
}
