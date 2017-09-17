using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
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
    /// SettingPage.xaml에 대한 상호 작용 논리
    /// </summary>
    public partial class SettingPage : Page
    {
        struct StationInfo
        {
            public string name;
            public string line;
            public string code;
        }
        List<StationInfo> NearStationNames = new List<StationInfo>();
        int Idx;
        public SettingPage()
        {
            InitializeComponent();
            InitComboBox();
        }

        private void InitComboBox()
        {
            NearStationNames.Add(new StationInfo { name = "", line = "", code = "" });
            BaseStationComboBox.Items.Add("사용안함");

            var url = "http://172.16.0.35:8000/getStations";

            // Json String to Object 로 반환
            JArray ja = JArray.Parse(GetResponseString(url));

            foreach (JObject item in ja)
            {
                var name = (string)item["name"];
                var line = (string)item["line"];
                var code = (string)item["station_code"];
                NearStationNames.Add(new StationInfo { name = name, line = line, code = code });
                BaseStationComboBox.Items.Add(line+". "+name);

            }

            BaseStationComboBox.SelectedItem = Properties.Settings.Default.DefaultStationLine + ". " + Properties.Settings.Default.DefaultStationName;
        }                                      

        private void BaseStationComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Idx = ((ComboBox)sender).SelectedIndex;

            Properties.Settings.Default.DefaultStationName = NearStationNames[Idx].name;
            Properties.Settings.Default.DefaultStationLine = NearStationNames[Idx].line;
            Properties.Settings.Default.DefaultStationCode = NearStationNames[Idx].code;
            Properties.Settings.Default.Save();
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
    }
}
