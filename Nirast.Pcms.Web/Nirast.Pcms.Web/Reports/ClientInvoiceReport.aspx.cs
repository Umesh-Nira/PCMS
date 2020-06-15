using Ionic.Zip;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.pdf.parser;
using Microsoft.Reporting.WebForms;
using Newtonsoft.Json;
using Nirast.Pcms.Web.Helpers;
using Nirast.Pcms.Web.Logger;
using Nirast.Pcms.Web.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Reflection;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Nirast.Pcms.Web.Reports
{
    public partial class ClientInvoiceReport : System.Web.UI.Page
    {
        PCMSLogger pCMSLogger = new PCMSLogger();
        List<string> myFiles = new List<string>();
        List<InvoiceSearchInpts> listInvoiceInputs = new List<InvoiceSearchInpts>();
        DateTime fromdate = DateTime.MinValue, todate = DateTime.MinValue;
        string monthText;
        PaymentAdvancedSearch searchInputs = new PaymentAdvancedSearch();
        int year;
        int NextInvoiceNumber,InvoiceNumber;
        List<ScheduledData> scheduleDetailsList = new List<ScheduledData>();
        List<ScheduledData> scheduleDetailsListSeperateInvoice = new List<ScheduledData>();
        string InvoicePrefix;
        string invoiceAddress = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            if (!IsPostBack)
            {
                try
                {

                    string script = "$(document).ready(function () { $('[id*=btnSubmit]').click(); });";
                    ClientScript.RegisterStartupScript(this.GetType(), "load", script, true);

                    ReportViewer1.ProcessingMode = ProcessingMode.Local;
                    ReportViewer1.ShowRefreshButton = false;
                    ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Reports/ClientInvoice.rdlc");
                    ReportViewer1.Visible = false;
                    ReportViewer2.Visible = false;

                    PaymentAdvancedSearch searchInputs = new PaymentAdvancedSearch();
                    List<ScheduledData> scheduleDetailsList = new List<ScheduledData>();
                    DateTime fromdate = DateTime.MinValue, todate = DateTime.MinValue;
                    int clientId = Convert.ToInt32(Request.QueryString["clientId"]);
                    int category = Convert.ToInt32(Request.QueryString["category"]);
                    bool isOrientation = Convert.ToBoolean(Request.QueryString["isOrientation"]);
                    int year = Convert.ToInt32(Request.QueryString["year"]);
                    int month = Convert.ToInt32(Request.QueryString["month"]);
                    string monthText = (Request.QueryString["monthText"]);
                    if (Request.QueryString["fromdate"] != "")
                    {
                        fromdate = Convert.ToDateTime(Request.QueryString["fromdate"]);
                    }
                    if (Request.QueryString["todate"] != "")
                    {
                        todate = Convert.ToDateTime(Request.QueryString["todate"]);
                    }
                    searchInputs.ClientId = clientId;
                    searchInputs.CareTakerId = 0;
                    searchInputs.FromDate = fromdate;
                    searchInputs.ToDate   = todate;
                    searchInputs.Category = category;
                    if (month == 0)
                    {
                        searchInputs.Year = 0;
                    }
                    else
                    {
                        searchInputs.Year = 0;
                    }
                    searchInputs.Month = 0;
                    if(year !=0 &&  month !=0)
                    {
                        searchInputs.FromDate = new DateTime(year, month, 1);   //new DateTime(year, month, 1);
                        searchInputs.ToDate = new DateTime(year, month, DateTime.DaysInMonth(year, month));

                    }
                    if(year !=0 && month ==0 && fromdate == DateTime.MinValue)
                    {
                        searchInputs.FromDate = new DateTime(year, 1, 1);
                        searchInputs.ToDate  = new DateTime(year, 12, 31);
                    }


                    searchInputs.IsOrientation = isOrientation;
                    Service service = new Service();
                    string api = "Home/GetClientScheduledDetails";
                    var advancedSearchInputModel = JsonConvert.SerializeObject(searchInputs);
                    var result = service.PostAPIWithData(advancedSearchInputModel, api);
                    scheduleDetailsList = JsonConvert.DeserializeObject<List<ScheduledData>>(result.Result);

                    if (scheduleDetailsList.Count != 0)
                    {
                        invoiceAddress = scheduleDetailsList[0].InvoiceAddress;

                    }
                    if (null == invoiceAddress)
                    {
                        invoiceAddress = "";
                    }

                    if (searchInputs.FromDate != DateTime.MinValue)
                    {
                        scheduleDetailsList = scheduleDetailsList.Where(a => Convert.ToDateTime(a.Startdate).Date <= Convert.ToDateTime(searchInputs.ToDate).Date).Where(a => Convert.ToDateTime(a.Startdate).Date >= Convert.ToDateTime(searchInputs.FromDate).Date).ToList();
                    }

                    List<ScheduledData> holidaySchedules = new List<ScheduledData>();
                    holidaySchedules = scheduleDetailsList.Where(x => x.HoildayHours != 0).ToList();


                    scheduleDetailsList = scheduleDetailsList.Where(x => x.HoildayHours == 0).GroupBy(l => l.SchedulingId)
                                                         .Select(cl =>  new ScheduledData
                                                         {
                                                             
                                                             SchedulingId = cl.First().SchedulingId,
                                                             ClientName = cl.First().ClientName,
                                                             CurrencySymbol = cl.First().CurrencySymbol,
                                                             StartDateTime = cl.First().StartDateTime,
                                                             BuildingName = cl.First().BuildingName,
                                                             StateName = cl.First().StateName,
                                                             Zipcode = cl.First().Zipcode,
                                                             Phone1 = cl.First().Phone1,
                                                             Startdate = cl.First().Startdate,
                                                             Enddate = cl.First().Enddate,
                                                             Description = cl.First().Description,
                                                             TimeIn = cl.First().TimeIn,
                                                             TimeOut = cl.First().EndDateTime > Convert.ToDateTime(searchInputs.ToDate).AddDays(1).Date ? "12:00 AM" : cl.First().EndDateTime.ToString("hh:mm tt"),
                                                             WorkTimeName = cl.First().WorkTimeName,
                                                             CareTakerName = cl.First().CareTakerName,
                                                             ServiceTypeName = cl.First().ServiceTypeName,
                                                             WorkModeName = cl.First().WorkModeName,
                                                             IsSeparateInvoice = cl.First().IsSeparateInvoice,
                                                             Rate = cl.First().Rate,
                                                             Amount = cl.First().Amount,
                                                             StateId = cl.First().StateId,
                                                             HoildayHours = cl.First().HoildayHours,
                                                             HoildayAmout = cl.First().HoildayAmout,
                                                             HolidayPayValue = cl.First().HolidayPayValue,
                                                             CountryId = cl.First().CountryId,
                                                             Hours = cl.Sum(k=>Convert.ToDecimal(k.Hours)).ToString(),
                                                             Total = cl.Sum(k => k.Total),
                                                             HST = cl.Sum(k => k.HST),
                                                             InvoiceNumber=cl.First().InvoiceNumber,
                                                             InvoicePrefix= cl.First().InvoicePrefix 
                                                         }).ToList();

                    scheduleDetailsList.AddRange(holidaySchedules);


                    List<ScheduledData> scheduleDetailsListFilterd = new List<ScheduledData>();
                    scheduleDetailsListFilterd = scheduleDetailsList.Where(a => a.IsSeparateInvoice == false).ToList();
                    List<ScheduledData> list1 = scheduleDetailsListFilterd;
                    list1 = list1.OrderBy(x => x.StartDateTime).ThenBy(x => x.TimeIn).ToList();
                    list1 = list1.GroupBy(p => p.ServiceTypeName).Select(g => g.First()).OrderBy(x => x.StartDateTime).ThenBy(x => x.TimeIn).ToList();
                    list1 = list1.OrderBy(x => x.ServiceTypeName).ToList();

                    for (int i = 0; i < list1.Count(); i++)
                    {
                        if (scheduleDetailsListFilterd.Count > 0)
                        {
                            foreach (var item in scheduleDetailsListFilterd.Where(w => w.ServiceTypeName == list1[i].ServiceTypeName))
                            {
                                item.InvoiceNumber = item.InvoiceNumber + i;
                                InvoiceNumber = item.InvoiceNumber;
                            }
                        }
                        else
                        {
                            foreach (var item in scheduleDetailsListFilterd.Where(w => w.ServiceTypeName == list1[i].ServiceTypeName))
                            {
                                item.InvoiceNumber = item.InvoiceNumber + i;
                                InvoiceNumber = item.InvoiceNumber;
                            }
                        }
                    }
                    ReportDataSource datasource = new ReportDataSource("ClientInvoice", scheduleDetailsListFilterd);
                    if (scheduleDetailsListFilterd.Count != 0)
                    {
                        ReportViewer1.Visible = true;
                    }
                    else
                    {
                        lblmessage.Visible = true;

                    }
                    ReportViewer1.LocalReport.DataSources.Clear();
                    ReportViewer1.LocalReport.DataSources.Add(datasource);
                    ReportParameterCollection reportParameters = new ReportParameterCollection();
                    reportParameters.Add(new ReportParameter("Year", year.ToString()));
                    reportParameters.Add(new ReportParameter("InvoiceDate", Convert.ToDateTime(DateTime.Now).ToString("dd MMM yyyy")));
                    reportParameters.Add(new ReportParameter("InvoiceAddress", invoiceAddress.ToString()));
                    if (monthText == "--Select Month--" || monthText == null)
                    {
                        reportParameters.Add(new ReportParameter("FromDate", Convert.ToDateTime(searchInputs.FromDate).ToString("dd MMM yyyy")));
                        reportParameters.Add(new ReportParameter("Todate", Convert.ToDateTime(searchInputs.ToDate).ToString("dd MMM yyyy")));
                       // reportParameters.Add(new ReportParameter("InvoiceDate", Convert.ToDateTime(DateTime.Now).ToString("dd MMM yyyy")));
                        ReportViewer1.LocalReport.DisplayName = "ClientInvoice" + "  " + Convert.ToDateTime(searchInputs.FromDate).ToString("dd MMM yyyy") + " to " + Convert.ToDateTime(searchInputs.ToDate).ToString("dd MMM yyyy");
                    }
                    else
                    {
                        reportParameters.Add(new ReportParameter("monthText", monthText.ToString()));
                        ReportViewer1.LocalReport.DisplayName = "ClientInvoice" + " " + monthText.ToString() + " " + year.ToString();

                    }

                    this.ReportViewer1.LocalReport.SetParameters(reportParameters);
                    this.ReportViewer1.LocalReport.Refresh();


                    ReportViewer2.ProcessingMode = ProcessingMode.Local;
                    ReportViewer2.ShowRefreshButton = false;
                    ReportViewer2.LocalReport.ReportPath = Server.MapPath("~/Reports/ClientInvoiceSeperately.rdlc");
                   // List<ScheduledData> scheduleDetailsListSeperateInvoice = new List<ScheduledData>();
                    scheduleDetailsListSeperateInvoice = scheduleDetailsList.Where(a => a.IsSeparateInvoice == true).ToList();

                    List<ScheduledData> list = scheduleDetailsListSeperateInvoice;
                    list = list.OrderBy(x => x.StartDateTime).ThenBy(x => x.TimeIn).ToList();
                    list = list.GroupBy(p => new { p.Description, p.ServiceTypeName }).Select(g => g.First()).OrderBy(x => x.StartDateTime).ThenBy(x => x.TimeIn).ToList();

                    for (int i = 0; i < list.Count(); i++)
                    {
                        if (scheduleDetailsListSeperateInvoice.Count > 0)
                        {
                            foreach (var item in scheduleDetailsListSeperateInvoice.Where(w => w.Description == list[i].Description && w.ServiceTypeName == list[i].ServiceTypeName))
                            {
                                item.InvoiceNumber = InvoiceNumber + 1 + i;
                                NextInvoiceNumber = item.InvoiceNumber;
                            }
                        }
                        else
                        {
                            foreach (var item in scheduleDetailsListSeperateInvoice.Where(w => w.Description == list[i].Description && w.ServiceTypeName == list[i].ServiceTypeName))
                            {
                                item.InvoiceNumber = InvoiceNumber + i;
                                NextInvoiceNumber = item.InvoiceNumber;
                            }
                        }
                    }



                    ReportDataSource datasourceNew = new ReportDataSource("ClientInvoice", scheduleDetailsListSeperateInvoice);
                    if (scheduleDetailsListSeperateInvoice.Count != 0)
                    {
                        ReportViewer2.Visible = true;
                    }
                    else
                    {
                        lblmessagesplit.Visible = true;

                    }
                    ReportViewer2.LocalReport.DataSources.Clear();
                    ReportViewer2.LocalReport.DataSources.Add(datasourceNew);
                    ReportParameterCollection reportParameters2 = new ReportParameterCollection();
                    reportParameters2.Add(new ReportParameter("InvoiceDate", Convert.ToDateTime(DateTime.Now).ToString("dd MMM yyyy")));
                    reportParameters2.Add(new ReportParameter("Year", year.ToString()));
                    reportParameters.Add(new ReportParameter("InvoiceAddress", invoiceAddress.ToString()));
                    if (monthText == "--Select Month--" || monthText == null)
                    {
             
                        reportParameters2.Add(new ReportParameter("FromDate", Convert.ToDateTime(searchInputs.FromDate).ToString("dd MMM yyyy")));
                        reportParameters2.Add(new ReportParameter("Todate", Convert.ToDateTime(searchInputs.ToDate).ToString("dd MMM yyyy")));
                       
                        //ReportViewer2.LocalReport.DisplayName = "ClientInvoice" + "  " + fromdate.ToString("dd MMM yyyy") + " to " + todate.ToString("dd MMM yyyy");
                        ReportViewer2.LocalReport.DisplayName = "ClientInvoice" + "  " + Convert.ToDateTime(searchInputs.FromDate).ToString("dd MMM yyyy") + " to " + Convert.ToDateTime(searchInputs.ToDate).ToString("dd MMM yyyy");

                    }
                    else
                    {
                        reportParameters2.Add(new ReportParameter("monthText", monthText.ToString()));
                        ReportViewer2.LocalReport.DisplayName = "ClientInvoice" + " " + monthText.ToString() + " " + year.ToString();

                    }

                    this.ReportViewer2.LocalReport.SetParameters(reportParameters2);
                    this.ReportViewer2.LocalReport.Refresh();

                    //foreach (var item in scheduleDetailsListSeperateInvoice)
                    //{
                    //    List<ScheduledData> test = new List<ScheduledData>();
                    //    test.Add(item);
                    //    ReportDataSource datasourceNew = new ReportDataSource("ClientInvoice", test);
                    //    this.ReportViewer1.LocalReport.DataSources.Add(datasourceNew);
                    //}
                    List<CompanyProfile> companyProfile = new List<CompanyProfile>();
                    string apia = "Admin/GetCompanyProfiles/0";
                    var results = service.GetAPI(apia);
                    CompanyProfile listCompanyProfile = JsonConvert.DeserializeObject<CompanyProfile>(results);
                    companyProfile.Add(listCompanyProfile);
                    ReportDataSource datasourceCompanyProfile = new ReportDataSource("CompanyProfile", companyProfile);

                    ReportViewer1.LocalReport.DataSources.Add(datasourceCompanyProfile);
                    ReportViewer2.LocalReport.DataSources.Add(datasourceCompanyProfile);

                    

                }
                catch (Exception ex)
                {
                    pCMSLogger.Error(ex, "Error occurred in Admin Controller-ClientInvoiceReport.cs");
                }

            }

        }

        public void refreshReportviewr()
        {
            int month = Convert.ToInt32(Request.QueryString["month"]);
            int mode = Convert.ToInt32(Request.QueryString["Mode"]);

            List<ScheduledData> list = scheduleDetailsListSeperateInvoice;
            list = list.OrderBy(x => x.StartDateTime).ThenBy(x => x.TimeIn).ToList();
            list = list.GroupBy(p => p.InvoiceNumber).Select(g => g.First()).OrderBy(x => x.StartDateTime).ThenBy(x => x.TimeIn).ToList();
            List<ScheduledData> initialList = scheduleDetailsListSeperateInvoice;
            List<List<ScheduledData>> listOfList = initialList.GroupBy(item => item.InvoiceNumber).Select(group => group.ToList<ScheduledData>()).ToList();
            foreach (var item in listOfList)
            {
                Warning[] warnings;
                string[] streamIds;
                string mimeType = string.Empty;
                string encoding = string.Empty;
                string extension = string.Empty;

                ReportViewer2.ProcessingMode = ProcessingMode.Local;
                ReportViewer2.ShowRefreshButton = false;
                ReportViewer2.LocalReport.ReportPath = Server.MapPath("~/Reports/ClientInvoiceSeperately.rdlc");

                ReportDataSource datasourceNew = new ReportDataSource("ClientInvoice", item);
                if (scheduleDetailsListSeperateInvoice.Count != 0)
                {
                    ReportViewer2.Visible = true;
                }
                else
                {
                    lblmessagesplit.Visible = true;

                }
                ReportViewer2.LocalReport.DataSources.Clear();
                ReportViewer2.LocalReport.DataSources.Add(datasourceNew);
                ReportParameterCollection reportParameters2 = new ReportParameterCollection();
                reportParameters2.Add(new ReportParameter("Year", year.ToString()));
                reportParameters2.Add(new ReportParameter("InvoiceAddress", invoiceAddress.ToString()));
                if (monthText == "--Select Month--")
                {
                    reportParameters2.Add(new ReportParameter("FromDate", Convert.ToDateTime(searchInputs.FromDate).ToString("dd MMM yyyy")));
                    reportParameters2.Add(new ReportParameter("Todate", Convert.ToDateTime(searchInputs.ToDate).ToString("dd MMM yyyy")));
                    ReportViewer2.LocalReport.DisplayName = "ClientInvoice" + "  " + fromdate.ToString("dd MMM yyyy") + " to " + todate.ToString("dd MMM yyyy");
                }
                else
                {
                    reportParameters2.Add(new ReportParameter("monthText", monthText.ToString()));
                    ReportViewer2.LocalReport.DisplayName = "ClientInvoice" + " " + monthText.ToString() + " " + year.ToString();

                }

                this.ReportViewer2.LocalReport.SetParameters(reportParameters2);
                this.ReportViewer2.LocalReport.Refresh();

                Service service = new Service();
                List<CompanyProfile> companyProfile = new List<CompanyProfile>();
                string apia = "Admin/GetCompanyProfiles/0";
                var results = service.GetAPI(apia);
                CompanyProfile listCompanyProfile = JsonConvert.DeserializeObject<CompanyProfile>(results);
                companyProfile.Add(listCompanyProfile);
                ReportDataSource datasourceCompanyProfile = new ReportDataSource("CompanyProfile", companyProfile);

               // ReportViewer1.LocalReport.DataSources.Add(datasourceCompanyProfile);
                ReportViewer2.LocalReport.DataSources.Add(datasourceCompanyProfile);
                   byte[] bytesSeprate = this.ReportViewer2.LocalReport.Render("PDF", null, out mimeType, out encoding, out extension, out streamIds, out warnings);

                //InvoiceSearchInpts invoicesearchinputs = new InvoiceSearchInpts();
                //invoicesearchinputs.InvoiceNumber = item[0].InvoiceNumber;
                //invoicesearchinputs.InvoicePrefix = InvoicePrefix + " " + Convert.ToString(item[0].InvoiceNumber - 1);
                //invoicesearchinputs.ClientId = item[0].ClientId;
                //invoicesearchinputs.StartDate = fromdate;
                //invoicesearchinputs.EndDate = todate;
                //invoicesearchinputs.Mode = mode;
                //invoicesearchinputs.Year = year;
                //invoicesearchinputs.Month = month;
                //invoicesearchinputs.Seperateinvoice = true;
                //invoicesearchinputs.Description = item[0].Description;
                //invoicesearchinputs.PdfFile = bytesSeprate;
                //listInvoiceInputs.Add(invoicesearchinputs);
            }
        }

        public void ExportToPdf(DataTable dt)
        {
            Document document = new Document();
            PdfWriter writer = PdfWriter.GetInstance(document, new FileStream("F://sample.pdf", FileMode.Create));
            document.Open();
            iTextSharp.text.Font font5 = iTextSharp.text.FontFactory.GetFont(FontFactory.HELVETICA, 5);

            PdfPTable table = new PdfPTable(dt.Columns.Count);
            PdfPRow row = null;
            float[] widths = new float[] { 4f, 4f, 4f, 4f };

            table.SetWidths(widths);

            table.WidthPercentage = 100;
            int iCol = 0;
            string colname = "";
            PdfPCell cell = new PdfPCell(new Phrase("Products"));

            cell.Colspan = dt.Columns.Count;

            foreach (DataColumn c in dt.Columns)
            {

                table.AddCell(new Phrase(c.ColumnName, font5));
            }

            foreach (DataRow r in dt.Rows)
            {
                if (dt.Rows.Count > 0)
                {
                    table.AddCell(new Phrase(r[0].ToString(), font5));
                    table.AddCell(new Phrase(r[1].ToString(), font5));
                    table.AddCell(new Phrase(r[2].ToString(), font5));
                    table.AddCell(new Phrase(r[3].ToString(), font5));
                }
            }
            document.Add(table);
            document.Close();
        }

        public class ListtoDataTable
        {
            public DataTable ToDataTable<T>(List<T> items)
            {
                DataTable dataTable = new DataTable(typeof(T).Name);
                //Get all the properties by using reflection   
                PropertyInfo[] Props = typeof(T).GetProperties(BindingFlags.Public | BindingFlags.Instance);
                foreach (PropertyInfo prop in Props)
                {
                    //Setting column names as Property names  
                    dataTable.Columns.Add(prop.Name);
                }
                foreach (T item in items)
                {
                    var values = new object[Props.Length];
                    for (int i = 0; i < Props.Length; i++)
                    {

                        values[i] = Props[i].GetValue(item, null);
                    }
                    dataTable.Rows.Add(values);
                }

                return dataTable;
            }
        }

        protected void btnSeperateFiles_Click(object sender, EventArgs e)
        {

            string pdfFilePath = @"C:\PdfFiles\sample.pdf";
            string outputPath = @"C:\SplitedPdfFiles";
            int interval = 10;
            int pageNameSuffix = 0;

            // Intialize a new PdfReader instance with the contents of the source Pdf file:  
            PdfReader reader = new PdfReader(pdfFilePath);

            FileInfo file = new FileInfo(pdfFilePath);
            string pdfFileName = file.Name.Substring(0, file.Name.LastIndexOf(".")) + "-";

            for (int pageNumber = 1; pageNumber <= reader.NumberOfPages; pageNumber += interval)
            {
                pageNameSuffix++;
                string newPdfFileName = string.Format(pdfFileName + "{0}", pageNameSuffix);
                SplitAndSaveInterval(pdfFilePath, outputPath, pageNumber, interval, newPdfFileName);
            }
        }

        private void SplitAndSaveInterval(string pdfFilePath, string outputPath, int startPage, int interval, string pdfFileName)
        {
            using (PdfReader reader = new PdfReader(pdfFilePath))
            {
                Document document = new Document();
                PdfCopy copy = new PdfCopy(document, new FileStream(outputPath + "\\" + pdfFileName + ".pdf", FileMode.Create));

                document.Open();

                for (int pagenumber = startPage; pagenumber < (startPage + interval); pagenumber++)
                {
                    if (reader.NumberOfPages >= pagenumber)
                    {
                        copy.AddPage(copy.GetImportedPage(reader, pagenumber));
                    }
                    else
                    {
                        break;
                    }

                }

                document.Close();
            }
        }

        private void MergePDFs(string outPutFilePath, List<string> filesPath)
        {
            List<PdfReader> readerList = new List<PdfReader>();
            foreach (string filePath in filesPath)
            {
                PdfReader pdfReader = new PdfReader(filePath);
                readerList.Add(pdfReader);
            }

            //Define a new output document and its size, type

            iTextSharp.text.Rectangle pagesize = new iTextSharp.text.Rectangle(2160, 2880);
            Document document = new Document(pagesize);
            //Create blank output pdf file and get the stream to write on it.
            PdfWriter writer = PdfWriter.GetInstance(document, new FileStream(outPutFilePath, FileMode.Create));
            document.Open();

            foreach (PdfReader reader in readerList)
            {
                for (int i = 1; i <= reader.NumberOfPages; i++)
                {
                    PdfImportedPage page = writer.GetImportedPage(reader, i);
                    document.Add(iTextSharp.text.Image.GetInstance(page));
                }
            }
            document.Close();
        }
    }

}