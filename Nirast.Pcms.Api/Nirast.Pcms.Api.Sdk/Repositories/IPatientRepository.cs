﻿using Nirast.Pcms.Api.Sdk.Entities;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Nirast.Pcms.Api.Sdk.Repositories
{
    public interface IPatientRepository : IGenericRepository<CaretakerBookingModel>
    {
        Task<UserBookingInvoiceReport> GetAdminDashboardBookingHistoryDetail(int BookingId);
        Task<IEnumerable<UserBookingInvoiceReport>> GetBookingHistoryListById(int publicUserId);
        Task<IEnumerable<UserInvoiceParams>> GetBookingInvoiceListforUserDashBoard(int publicUserId);
        Task<IEnumerable<UserInvoiceParams>> GetBookingInvoiceList(BookingHistorySearch bookingHistorySearch);
        Task<IEnumerable<UserBookingInvoiceReport>> GetBookingHistoryListForInvoiceGeneration(BookingHistorySearch bookingHistorySearch);
        Task<int> SaveCaretakerBooking(CaretakerBookingModel caretakerBooking);

        Task<IEnumerable<UserBookingInvoiceReport>> GetBookingHistoryList(BookingHistorySearch bookingHistorySearch);

        Task<IEnumerable<PaymentReportDetails>> GetCaretakerBookings(CaretakerWiseSearchReport bookingHistorySearch);

        string DownloadDbBackup(string path);

        Task<IEnumerable<CaretakerBookingReport>> GetBookingHistoryReport(CaretakerBookingReportModel caretakerBookingReport);

        Task<UserBookingInvoiceReport> GetBookingHistoryDetail(int BookingId);

        Task<UsersDetails> GetUserDetail(int BookingId);

    }
}
