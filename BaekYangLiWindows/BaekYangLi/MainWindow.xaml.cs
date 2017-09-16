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

namespace BaekYangLi
{
    /// <summary>
    /// MainWindow.xaml에 대한 상호 작용 논리
    /// </summary>
    public partial class MainWindow : Window
    {
        GeoCoordinateWatcher GW = new GeoCoordinateWatcher(GeoPositionAccuracy.High);
        
        public MainWindow()
        {
            InitializeComponent();
            GetGPS();
        }

        public void GetGPS()
        {
            bool started = GW.TryStart(true, TimeSpan.FromMilliseconds(2000));
            if (!started)
            {
                Console.WriteLine("GeoCoordinateWatcher timed out on start.");
            }

            GW.PositionChanged += PositionChanged;
        }

        private void PositionChanged(object sender, GeoPositionChangedEventArgs<GeoCoordinate> e)
        {
            if (e.Position.Location != null)
            {
                Console.WriteLine("Lat: {0}, Long: {1}",
                    e.Position.Location.Latitude,
                    e.Position.Location.Longitude);
                GW.Stop();
            }

        }
    }
}
