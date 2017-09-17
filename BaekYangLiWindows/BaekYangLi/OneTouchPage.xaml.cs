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
            if(Properties.Settings.Default.DefaultStationName != "")
            {
                UseDefaultStation();
                return;
            }
            bool started = GW.TryStart(true, TimeSpan.FromMilliseconds(2000));
            if (!started)
            {
                Console.WriteLine("GeoCoordinateWatcher timed out on start.");
            }

            GW.PositionChanged += PositionChanged;
        }

        private void UseDefaultStation()
        {
            NearStationNames.Clear();
            var name = Properties.Settings.Default.DefaultStationName;
            var line = Properties.Settings.Default.DefaultStationLine;
            var code = Properties.Settings.Default.DefaultStationCode;
           
            NearStationNames.Add(new StationInfo
            {
                name = name, line = line, code = code
            });
            SetStationImage(0);
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
            if (NearStationNames.Count <= 1)
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
            if (NearStationNames.Count <= 1)
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

            JArray ja = JArray.Parse(GetResponseString(url));
            /*
             * {"beginRow":null,"endRow":null,"curPage":null,"pageRow":null,"totalCount":4,"rowNum":1,"selectedCount":4,"subwayId":"1008","subwayNm":null,"updnLine":"상행","trainLineNm":"암사행 - 단대오거리방면","subwayHeading":"오른쪽","statnFid":"1008000823","statnTid":"1008000825","statnId":"1008000824","statnNm":"신흥","trainCo":null,"ordkey":"01002암사","subwayList":"1008","statnList":"1008000824","btrainSttus":null,"barvlDt":"240","btrainNo":"8062","bstatnId":"17","bstatnNm":"암사","recptnDt":"2017-09-17 09:19:48.0","arvlMsg2":"4분 후 (모란)","arvlMsg3":"모란","arvlCd":"99"},{"
             */
            int count = 0;
            foreach (JObject item in ja)
            {
                var des = (string)item["trainLineNumber"];
                var msg = (string)item["arvlMsg2"];
                switch (count)
                {
                    case 0:
                        InfoArr1.Content = "1. " + des + "  " + msg;
                        InfoArr1.Visibility = Visibility.Visible;
                        break;
                    case 1:
                        InfoArr2.Content = "2. " + des + "  " + msg;
                        InfoArr2.Visibility = Visibility.Visible;
                        break;
                    case 2:
                        InfoArr3.Content = "3. " + des + "  " + msg;
                        InfoArr3.Visibility = Visibility.Visible;
                        break;
                    case 3:
                        InfoArr4.Content = "4. " + des + "  " + msg;
                        InfoArr4.Visibility = Visibility.Visible;
                        break;
                    default:
                        break;
                }
                count++;
            }

            url = String.Format("http://172.16.0.35:8000/getTimetable/{0}",
                    NearStationNames[idx].code);
            var timetable = GetResponseString(url);

            JArray tables = JArray.Parse(timetable);

            foreach (JObject item in tables)
            {
                var tag = (int)item["inout_tag"];
                var end_station = (string)item["end_station"];
                var left_time = (string)item["left_time"];
                Label contents = new Label {
                    HorizontalContentAlignment = DummyLabel.HorizontalContentAlignment,
                    VerticalContentAlignment = DummyLabel.VerticalContentAlignment,
                    DataContext = DummyLabel.DataContext
                };
                contents.Visibility = Visibility.Visible;
                contents.Content = left_time + "  " + end_station;
                if (tag == 1)    //상행
                {
                    InTable.Children.Add(contents);
                }
                else            //하행
                { 
                    OutTable.Children.Add(contents);
                }
                {
                        
                }
                {

                }
            }

        }
    }
}
