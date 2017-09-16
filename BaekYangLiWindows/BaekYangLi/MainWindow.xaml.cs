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
        GeoCoordinateWatcher GW = new GeoCoordinateWatcher(GeoPositionAccuracy.High);

        public MainWindow()
        {
            InitializeComponent();
            InsideFrame.Navigate(new MapPage());
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
                var url = String.Format("http://172.16.0.35:8000/getNearStations/{0}/{1}",
                    e.Position.Location.Latitude,
                    e.Position.Location.Longitude);
               
                // Json String to Object 로 반환
                JArray jo = JArray.Parse(GetResponseString(url));

                GW.Stop();
                
            }

        }

        public string GetResponseString(string url)
        {
            WebClient client = new WebClient();
            client.Encoding = Encoding.UTF8;
            // 웹 URL을 통해 String 데이터로 반환
            return client.DownloadString(url);
        }
        
    }
}
