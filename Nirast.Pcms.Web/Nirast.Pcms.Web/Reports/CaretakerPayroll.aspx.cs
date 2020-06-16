﻿using Microsoft.Reporting.WebForms;
using Newtonsoft.Json;
using Nirast.Pcms.Web.Helpers;
using Nirast.Pcms.Web.Logger;
using Nirast.Pcms.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;

namespace Nirast.Pcms.Web.Reports
{
    public partial class CaretakerPayroll : System.Web.UI.Page
    {
        PCMSLogger Logger = new PCMSLogger();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    ReportViewer1.ProcessingMode = ProcessingMode.Local;
                    ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Reports/CaregiverPayrollSummary.rdlc");
                    ReportViewer1.Visible = false;
                    PaymentAdvancedSearch searchInputs = new PaymentAdvancedSearch();
                    List<InvoiceReportData> scheduleDetailsList = new List<InvoiceReportData>();
                    DateTime fromdate = DateTime.MinValue, todate = DateTime.MinValue;
                    int caretaker = 0, year = 0, month = 0, workmode = 0, category = 0, client = 0;
                    bool isOrientation = Convert.ToBoolean(Request.QueryString["isOrientation"]);
                    string categoryName = (Request.QueryString["categoryText"]);
                    string caretakerText = (Request.QueryString["caretakerText"]) != "" ? (Request.QueryString["caretakerText"]) : "--Select--";
                    if (Request.QueryString["clientId"] != "null" && Request.QueryString["clientId"] != "")
                    {
                        client = Convert.ToInt32(Request.QueryString["clientId"]);
                    }

                    if (Request.QueryString["caretaker"] != "null" && Request.QueryString["caretaker"] != "")
                    {
                        caretaker = Convert.ToInt32(Request.QueryString["caretaker"]);
                    }
                    if (Request.QueryString["year"] != "null" && Request.QueryString["year"] != "")
                    {
                        year = Convert.ToInt32(Request.QueryString["year"]);
                    }
                    if (Request.QueryString["month"] != "null" && Request.QueryString["month"] != "")
                    {
                        month = Convert.ToInt32(Request.QueryString["month"]);
                    }
                    if (Request.QueryString["work"] != "null" && Request.QueryString["work"] != "")
                    {
                        workmode = Convert.ToInt32(Request.QueryString["work"]);
                    }
                    if (Request.QueryString["category"] != "null" && Request.QueryString["category"] != "")
                    {
                        category = Convert.ToInt32(Request.QueryString["category"]);
                    }

                    if (Request.QueryString["fromdate"] != "")
                    {
                        fromdate = Convert.ToDateTime(Request.QueryString["fromdate"]);
                    }
                    if (Request.QueryString["todate"] != "")
                    {
                        todate = Convert.ToDateTime(Request.QueryString["todate"]);
                    }
                    Logger.Info("Caretaker: " + caretaker.ToString());
                    Logger.Info("Client: " + client.ToString());

                    searchInputs.Service = workmode;
                    searchInputs.Category = category;
                    searchInputs.CareTakerId = caretaker;
                    searchInputs.FromDate = fromdate;
                    searchInputs.ToDate = todate;


                    if (month == 0)
                    {
                        searchInputs.Year = 0;
                    }
                    else
                    {
                        searchInputs.Year = year;
                    }
                    searchInputs.Month = 0;
                    if (year != 0 && month != 0)
                    {
                        searchInputs.FromDate = new DateTime(year, month, 1);   //new DateTime(year, month, 1);
                        searchInputs.ToDate = new DateTime(year, month, DateTime.DaysInMonth(year, month));

                    }
                    if (year != 0 && month == 0 && fromdate == DateTime.MinValue)
                    {
                        searchInputs.FromDate = new DateTime(year, 1, 1);
                        searchInputs.ToDate = new DateTime(year, 12, 31);
                    }


                    searchInputs.ClientId = client;
                    searchInputs.IsOrientation = isOrientation;

                    Service service = new Service();
                    string api = "Home/SearchClientInvoiceReportSummary";
                    var advancedSearchInputModel = JsonConvert.SerializeObject(searchInputs);
                    var result = service.PostAPIWithData(advancedSearchInputModel, api);
                    scheduleDetailsList = JsonConvert.DeserializeObject<List<InvoiceReportData>>(result.Result);

                    scheduleDetailsList = scheduleDetailsList.GroupBy(l => new { l.CaretakerName, l.WorkShiftName, l.TypeRate })
                                                        .Select(cl => new InvoiceReportData
                                                        {

                                                            Category = cl.First().Category,
                                                            ClientName = cl.First().ClientName,
                                                            CaretakerName = cl.First().CaretakerName,
                                                            WorkShiftName = cl.First().WorkShiftName,
                                                            ClientId = cl.First().ClientId,
                                                            CaretakerUserId = cl.First().CaretakerUserId,
                                                            WorkShiftId = cl.First().WorkShiftId,
                                                            BillingHours = cl.First().BillingHours,
                                                            HolidayHours = cl.Sum(l => Convert.ToDouble(l.HolidayHours)),
                                                            HolidayRate = cl.First().HolidayRate,
                                                            NormalHours = cl.Sum(k => Convert.ToDouble(k.NormalHours)),
                                                            TypeRate = cl.First().TypeRate,
                                                            HolidayPay = cl.First().HolidayPay,
                                                            NormalPay = cl.First().NormalPay,
                                                            TotalPay = cl.Sum(k => k.TotalPay)
                                                        }).OrderBy(cl => cl.CaretakerName.First()).ToList();


                    //List<InvoiceReportData> scheduleDetailsListFilterd = new List<InvoiceReportData>();
                    //scheduleDetailsListFilterd = scheduleDetailsList.ToList();

                    if (scheduleDetailsList.Count != 0)
                    {
                        ReportViewer1.Visible = true;
                    }
                    else
                    {
                        lblmessage.Visible = true;

                    }

                    ReportDataSource datasource = new ReportDataSource("InvoicePayHoursSummary", scheduleDetailsList);
                    ReportParameterCollection reportParameters = new ReportParameterCollection();

                    string monthText = "--Select Month--";
                    reportParameters.Add(new ReportParameter("Year", year.ToString()));
                    if (monthText == "--Select Month--" || monthText == null)
                    {
                        reportParameters.Add(new ReportParameter("FromDate", Convert.ToDateTime(searchInputs.FromDate).ToString("dd MMM yyyy")));
                        reportParameters.Add(new ReportParameter("Todate", Convert.ToDateTime(searchInputs.ToDate).ToString("dd MMM yyyy")));
                    }
                    else
                    {
                        reportParameters.Add(new ReportParameter("monthText", monthText.ToString()));
                    }
                    reportParameters.Add(new ReportParameter("category", categoryName));
                    reportParameters.Add(new ReportParameter("caretaker", caretakerText));
                    this.ReportViewer1.LocalReport.SetParameters(reportParameters);
                    this.ReportViewer1.LocalReport.Refresh();

                    ReportViewer1.LocalReport.DataSources.Clear();
                    ReportViewer1.LocalReport.DataSources.Add(datasource);
                    string apia = "Admin/GetCompanyProfiles/0";
                    var results = service.GetAPI(apia);
                    List<CompanyProfile> listCompanyProfile = new List<CompanyProfile>();
                    CompanyProfile companyProfile = JsonConvert.DeserializeObject<CompanyProfile>(results);
                    listCompanyProfile.Add(companyProfile);
                    ReportDataSource datasourceCompanyProfile = new ReportDataSource("CompanyProfile", listCompanyProfile);

                    ReportViewer1.LocalReport.DataSources.Add(datasourceCompanyProfile);
                    //ReportViewer1.SizeToReportContent = true;
                }
                catch (Exception ex)
                {
                    Logger.Error(ex, "Error occurred in Admin Controller-Interview");
                }
            }
        }
    }
}