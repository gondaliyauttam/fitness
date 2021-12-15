class ApiService {
  static const baseUrl = 'http://fitness.kriyaninfotech.com';
  static const loginApi = baseUrl + '/api/login';
  static const regApi = baseUrl + '/api/register';
  static const userprofile = baseUrl + '/api/userProfile';
  static const editprofile = baseUrl + '/api/editProfile';
  static const wod = baseUrl + '/api/wodList';
  static const personalTrainer = baseUrl + '/api/trainerList';
  static const dashBoard = baseUrl + '/api/categories';
  static const forgotPassword = baseUrl + '/api/forgotPassword';
  static const checkOtp = baseUrl + '/api/checkOTP';
  static const resetPassword = baseUrl + '/api/resetPassword';
  static const subCategories = baseUrl + '/api/subCategories';
  static const wodDetails = baseUrl + '/api/wodDetails';
  static const calender = baseUrl + '/api/calenderEvents';
  static const searchCat = baseUrl + '/api/subCategories';
  static const allvideos = baseUrl + '/api/allvideos';
  static const bookedSlots = baseUrl + '/api/savetrainerslots';
  static const qrLogin = baseUrl + '/api/qrlogin';
  static const memberCalenderList = baseUrl + '/api/memberCalenderList';
  // static const trainerslist = baseUrl + '/api/trainerslist';
  // static const trainerslots = baseUrl + '/api/trainerslots';
  static const trainerSlotsBooking = baseUrl + '/api/trainerslotbooking';
  static const userScheduledTrainer = baseUrl + '/api/usertrainerschedule';
  static const usertrainersscheduledlist =
      baseUrl + '/api/usertrainersscheduledlist';

  static bool isAppBar = false;
}
