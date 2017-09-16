using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Device.Location;
using System.Linq;
using System.Net;
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
using System.Windows.Shapes;

namespace BaekYangLi
{
    /// <summary>
    /// OneTouchPage.xaml에 대한 상호 작용 논리
    /// </summary>
    public partial class OneTouchPage : Page
    {
        struct StationInfo
        {
            public string name;
            public string line;
            public string code;
        }
        GeoCoordinateWatcher GW = new GeoCoordinateWatcher(GeoPositionAccuracy.High);
        List<StationInfo> NearStationNames = new List<StationInfo>();
        int Idx = 0;
        public OneTouchPage()
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
                var url = String.Format("http://172.16.0.35:8000/getNearStations/{0}/{1}",
                    e.Position.Location.Latitude,
                    e.Position.Location.Longitude);

                // Json String to Object 로 반환
                JArray ja = JArray.Parse(GetResponseString(url));

                foreach (JObject item in ja)
                {
                    var name = (string)item["name"];
                    var line = (string)item["line"];
                    var code = (string)item["station_code"];
                    StationInfo info = new StationInfo
                    {
                        line = line,
                        name = name,
                        code = code
                    };


                    NearStationNames.Add(info);
                }
                
                GW.Stop();

                if (NearStationNames.Count > 0)
                {
                    Idx = 0;
                    SetStationImage(Idx);
                }
                

            }

        }

        public string GetResponseString(string url)
        {
            WebClient client = new WebClient
            {
                Encoding = Encoding.UTF8
            };
            // 웹 URL을 통해 String 데이터로 반환
            return client.DownloadString(url);
        }

        private void NextBtnClick(object sender, RoutedEventArgs e)
        {
            if (NearStationNames.Count < 1)
                return;
            Idx++;
            if (NearStationNames.Count <= Idx)
            {
                Idx = 0;             
            }

            SetStationImage(Idx);
        }

        private void PrevBtnClick(object sender, RoutedEventArgs e)
        {
            if (NearStationNames.Count < 1)
                return;
            Idx--;
            if (0 > Idx)
            {
                Idx = NearStationNames.Count-1;
            }
            SetStationImage(Idx);

        }

        private void SetStationImage(int idx)
        {
            LineNum.Content = NearStationNames[Idx].line;
            StartStationName.Content = NearStationNames[Idx].name;
            PrintStationInfo(idx);
        }

        private void PrintStationInfo(int idx)
        {
            var url = String.Format("http://172.16.0.35:8000/getArrivalTimeLive/{0}",
                    NearStationNames[idx].name);
            var arrival = GetResponseString(url);

            url = String.Format("http://172.16.0.35:8000/getArrivalTimeOfStation/{0}",
                    NearStationNames[idx].code);

            var timetable = GetResponseString(url);

        }
    }
}
