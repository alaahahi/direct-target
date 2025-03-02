// ignore_for_file: file_names

import 'package:get/get.dart';

abstract class AppTranslation extends Translations {
  static Map<String, Map<String, String>> translationKeys = {
    'en': en,
    'ar': ar,
  };
}

final Map<String, String> en = {
  "welcome": "Welcome",
  "hello": "Hello, how are you?",
  "Upcoming": "Upcoming",
  "Completed": "Completed",
  "Cancel": "Cancel",
  "Login": "Login",
  "SMS Code": "SMS Code",
  "WhatsApp": "WhatsApp",
  "Lets get Started!": "Lets get Started!",
  "Login to enjoy the features we've \nprovided, and stay healthy": "Login to enjoy the features we've \nprovided, and stay healthy",
  "Sign in as a Visitor": "Sign in as a Visitor",
  "Resend": "Resend",
  "Don't recieve code yet? ": "Don't recieve code yet? ",
  "Verify": "Verify",
  "Enter verification code we have sent to your\nnumber": "Enter verification code we have sent to your\nnumber",
  "Consult only with a doctor\nyou trust": "Consult only with a doctor\nyou trust",
  "Find a lot of specialist\ndoctors in one place": "Find a lot of specialist\ndoctors in one place",
  "Get connect our Online\nConsultation": "Get connect our Online\nConsultation",
  "Skip": "Skip",
  "Done": "Done",
  "Next": "Next",
  "Profile": "Profile",
  "Weight": "Weight",
  "Heart rate": "Heart rate",
  "Calories": "Calories",
  "Change": "Change",
  "Date": "Date",
  "Cardiologist": "Cardiologist",
  "Dr. Marcus Horizon": "Dr. Marcus Horizon",
  "Reasion": "Reasion",
  "Chest pain": "Chest pain",
  "Payment Details": "Payment Details",
  "Consultation": "Consultation",
  "Admin Fee": "Admin Fee",
  "Aditional Discount": "Aditional Discount",
  "Top Doctors": "Top Doctors",
  "Total": "Total",
  "Payment Method": "Payment Method",
  "Visa": "Visa",
  "Book": "Book",
  "Select Date and Time": "Select Date and Time",
  "Book an Appointment": "Book an Appointment",
  "Book Now": "Book Now",
  "News for up-to-the-minute news, breaking news, video, audio and feature stories.": "News for up-to-the-minute news, breaking news, video, audio and feature stories.",
  "Search doctor, drugs, articles...": "Search doctor, drugs, articles...",
  "Doctor": "Doctor",
  "Top Doctor": "Top Doctor",
  "Pharmacy": "Pharmacy",
  "Hospital": "Hospital",
  "Ambulance": "Ambulance",
  "See all": "See all",
  "Chardiologist": "Chardiologist",
  "About": "About",
  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod elipss this is just a dummy text with some free lines do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam consectetur adipiscing elit. Sed euismod ...": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod elipss this is just a dummy text with some free lines do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam consectetur adipiscing elit. Sed euismod ...",
  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod elipss this is just a dummy text with some free ... ": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod elipss this is just a dummy text with some free ... ",
  "Read less": "Read less",
  "Read more": "Read more",
  "Find Doctor": "Find Doctor",
  "General": "General",
  "Lungs Prob": "Lungs Prob",
  "Dentist": "Dentist",
  "Psychiatrist": "Psychiatrist",
  "Covid": "Covid",
  "Injection": "Injection",
  "Recommended Doctors":  "Recommended Doctors",
  "Your Recent Doctors": "Your Recent Doctors",
  "Health Center": "Health Center",
  "Services": "Services",
  "Blood Test Service": "Blood Test Service",
  "Before Discount: 100 EGP - After Discount: 80 EGP": "Before Discount: 100 EGP - After Discount: 80 EGP",
  "Available Doctors": "Available Doctors",
  "Specialty: General Medicine\nPhone:0147852369": "Specialty: General Medicine\nPhone:0147852369",
  "Show Details": "Show Details",
  "Services:": "Services:",
  "discount": "discount",
  "Nothing to show": "Nothing to show",
  "Confirmed": "Confirmed",
  "Reschedule": "Reschedule",
  "Consultion Start": "Consultion Start",
  "You can consult your problem to the doctor": "You can consult your problem to the doctor",
  "10 min ago": "10 min ago",
  "Learn More": "Learn More",
  "Early protection for\nyour family health": "Early protection for\nyour family health",
  "My Saved": "My Saved",
  "Appointment": "Appointment",
  "FAQs": "FAQs",
  "Log out": "Log out",
  "All Services":"All Services",
  "Verify SMS":"Verify SMS",
  "Verify WhatsApp":"Verify WhatsApp",
  "Verification failed":"Verification failed",
  "You must enter a phone number":"You must enter a phone number",
  "The number must consist of 10 digits":"The number must consist of 10 digits",

  "Verify Phone Number":"Verify Phone Number",
  "We sent a verification code to":"We sent a verification code to",
  'Please enter a valid 6-digit OTP':'Please enter a valid 6-digit OTP',
  "Code expires in":"Code expires in",
  "sec":"sec",
  "Resend Code":"Resend Code",
  'Verify Code':'Verify Code',

  "Request Card":"Request Card",
  "Join Now":"Join Now",
  "No data available":"No data available",
  'Your Name':'Your Name',
  'Your Phone Number':'Your Phone Number',
  'Your Family Names':'Your Family Names',
  'Your Weight (kg)':'Your Weight (kg)',
  'Your Height (cm)':'Your Height (cm)',
  "Select Gender":"Select Gender",
  "male":"male",
  "Female":"Female",

  "Update Profile":"Update Profile",
  "gender":"gender",
  "height":"height",
  "weight":"weight",
  "family":"family",
  'Change Profile':'Change Profile',
  'Change Language':'Change Language',
  'Privacy Policy':'Privacy Policy',
  'Terms & Conditions':'Terms & Conditions',
  "Weight":"Weight",
  "Height":"Height",
  "Gender":"Gender",
  "No profile data found":"No profile data found",
  'Add Card Image':'Add Card Image',
  'Full Name':'Full Name',
  'Card Number':'Card Number',
  'Address':'Address',
  'Number of family members':'Number of family members',
  'Member Name':'Member Name',
  "No Appointments Found":"No Appointments Found",
  "Note":"Note",
  "No Completed Appointments":"No Completed Appointments",
  "No Canceled Appointments":"No Canceled Appointments",
  "Edit Book Appointment":"Edit Book Appointment",
  "No profile data found":"No profile data found",
  "No working hours available":"No working hours available",
  "About":"About",
  'Update Appointment':'Update Appointment',
  "Error" :"Error",
  "Please select a date and time":"Please select a date and time",
  "Book Appointment":"Book Appointment",
  'Create Appointment':'Create Appointment',
  'Update Appointment':'Update Appointment',
  "No Services Available":"No Services Available",
  "Confirm Logout":"Confirm Logout",
  "Language":"Language",
  "Privacy & Policy":"Privacy & Policy",
  "Terms & Condition":"Terms & Condition",
  "Are you sure you want to log out?":"Are you sure you want to log out?",
  "No":"No",
  "Yes":"Yes",
  "Log out":"Log out",
  "The code was sent successfully":"The code was sent successfully",
  "Alert":"Alert",
  "No data was modified":"No data was modified",
  "Success": "Success",
  "The appointment was updated successfully":"The appointment was updated successfully",
  "An error occurred while updating the appointment":"An error occurred while updating the appointment",
  "Unknown error":"Unknown error",
  "The code was sent successfully":"The code was sent successfully",
  "An error occurred while sending the code": "An error occurred while sending the code",
  'App Information':'App Information',
  'Contact Us':'Contact Us',
  'Get in Touch': 'Get in Touch',
  'your_name': 'Your Name',
  'your_email': 'Your Email',
  'your_message': 'Your Message',
  'send_message': 'Send Message',
  'contact_info': 'Contact Information',
  'phone': 'Phone',
  'email': 'Email',
  'location': 'Location',
  'Please enter your name': 'Please enter your name',
  'Please enter a valid email': 'Please enter a valid email',
  'Please enter your message': 'Please enter your message',
  'success_message': 'Message Sent Successfully!',
  "Services of Card":"Services of Card",
  'Phone Number':'Phone Number',
  "Featured Services":"Featured Services",
  "Available Hours":"Available Hours",
  "Available Days":"Available Days",
  'Search Services':'Search Services',
  "Price":"Price"
}
;
final Map<String, String> ar = {
  "welcome": "مرحباً",
  "hello": "مرحباً، كيف حالك؟",
  "Upcoming": "القادمة",
  "Completed": "المكتملة",
  "Cancel": "إلغاء",
  "Login": "تسجيل الدخول",
  "SMS Code": "رمز الرسائل",
  "WhatsApp": "واتساب",
  "Lets get Started!": "لنبدأ!",
  "Login to enjoy the features we've \nprovided, and stay healthy": "سجّل الدخول للاستمتاع بالمزايا التي نقدمها \nواحافظ على صحتك",
  "Sign in as a Visitor": "تسجيل الدخول كزائر",
  "Resend": "إعادة الإرسال",
  "Don't recieve code yet? ": "لم تستلم الرمز بعد؟ ",
  "Verify": "تحقق",
  "Enter verification code we have sent to your\nnumber": "أدخل رمز التحقق الذي أرسلناه إلى \nرقمك",
  "Consult only with a doctor\nyou trust": "استشر فقط طبيباً تثق به",
  "Find a lot of specialist\ndoctors in one place": "اعثر على العديد من الأطباء المتخصصين في مكان واحد",
  "Get connect our Online\nConsultation": "تواصل مع استشارتنا عبر الإنترنت",
  "Skip": "تخطي",
  "Done": "تم",
  "Next": "التالي",
  "Profile": "الملف الشخصي",
  "Weight": "الوزن",
  "Heart rate": "معدل ضربات القلب",
  "Calories": "السعرات الحرارية",
  "Change": "تغيير",
  "Date": "التاريخ",
  "Cardiologist": "طبيب القلب",
  "Dr. Marcus Horizon": "الدكتور ماركوس هورايزون",
  "Reasion": "السبب",
  "Chest pain": "ألم الصدر",
  "Payment Details": "تفاصيل الدفع",
  "Consultation": "الاستشارة",
  "Admin Fee": "رسوم إدارية",
  "Aditional Discount": "خصم إضافي",
  "Top Doctors": "أفضل الأطباء",
  "Total": "الإجمالي",
  "Payment Method": "طريقة الدفع",
  "Visa": "فيزا",
  "Book": "احجز",
  "Select Date and Time": "اختر التاريخ والوقت",
  "Book an Appointment": "احجز موعداً",
  "Book Now": "احجز الآن",
  "News for up-to-the-minute news, breaking news, video, audio and feature stories.": "أخبار لأحدث المستجدات، والأخبار العاجلة، والفيديوهات، والمواد الصوتية والقصص المميزة.",
  "Search doctor, drugs, articles...": "ابحث عن طبيب، أدوية، مقالات...",
  "Doctor": "طبيب",
  "Top Doctor": "أفضل طبيب",
  "Pharmacy": "صيدلية",
  "Hospital": "مستشفى",
  "Ambulance": "سيارة الإسعاف",
  "See all": "عرض الكل",
  "Chardiologist": "طبيب القلب",
  "About": "حول",
  "Read less": "عرض أقل",
  "Read more": "عرض المزيد",
  "Find Doctor": "ابحث عن طبيب",
  "General": "عام",
  "Lungs Prob": "مشاكل الرئة",
  "Dentist": "طبيب الأسنان",
  "Psychiatrist": "طبيب نفسي",
  "Covid": "كوفيد",
  "Injection": "حقنة",
  "Recommended Doctors": "الأطباء الموصى بهم",
  "Your Recent Doctors": "أطباؤك السابقون",
  "Health Center": "مركز صحي",
  "Services": "الخدمات",
  "Blood Test Service": "خدمة تحليل الدم",
  "Before Discount: 100 EGP - After Discount: 80 EGP": "قبل الخصم: 100 جنيه - بعد الخصم: 80 جنيه",
  "Available Doctors": "الأطباء المتاحون",
  "Specialty: General Medicine\nPhone:0147852369": "التخصص: الطب العام\nالهاتف: 0147852369",
  "Show Details": "عرض التفاصيل",
  "Services:": "الخدمات:",
  "discount": "خصم",
  "Nothing to show": "لا يوجد شيء لعرضه",
  "Confirmed": "تم التأكيد",
  "Reschedule": "إعادة الجدولة",
  "Consultion Start": "بداية الاستشارة",
  "You can consult your problem to the doctor": "يمكنك استشارة الطبيب حول مشكلتك",
  "10 min ago": "منذ 10 دقائق",
  "Learn More": "تعرف على المزيد",
  "Early protection for\nyour family health": "الحماية المبكرة لصحة\nعائلتك",
  "My Saved": "محفوظاتي",
  "Appointment": "الموعد",
  "FAQs": "الأسئلة الشائعة",
  "Log out": "تسجيل الخروج",
  "All Services":"كافة الخدمات",







  "Verify SMS": "تحقق من الرسائل القصيرة",
  "Verify WhatsApp": "تحقق من واتساب",
  "Verification failed": "فشل التحقق",
  "You must enter a phone number":"يجب إدخال رقم الهاتف",
  "The number must consist of 10 digits":"يجب أن يكون الرقم مكونًا من 10 أرقام",
  "Verify Phone Number": "تحقق من رقم الهاتف",
  "We sent a verification code to": "أرسلنا رمز التحقق إلى",
  "Please enter a valid 6-digit OTP": "يرجى إدخال رمز OTP صالح مكون من 6 أرقام",
  "Code expires in": "ينتهي الرمز خلال",
  "sec":"ثانية",
  "Resend Code": "إعادة إرسال الرمز",
  "Verify Code": "تحقق من الرمز",

  "Request Card": "طلب بطاقة",
  "Join Now": "انضم الآن",
  "No data available": "لا توجد بيانات متاحة",
  "Your Name": "اسمك",
  "Your Phone Number": "رقم هاتفك",
  "Your Family Names": "أسماء عائلتك",
  "Your Weight (kg)": "وزنك (كجم)",
  "Your Height (cm)": "طولك (سم)",
  "Select Gender": "اختر الجنس",
  "male": "ذكر",
  "Female": "أنثى",

  "Update Profile": "تحديث الملف الشخصي",
  "gender": "الجنس",
  "height": "الطول",
  "weight": "الوزن",
  "family": "العائلة",
  "Change Profile": "تغيير الملف الشخصي",
  "Change Language": "تغيير اللغة",
  "Privacy Policy": "سياسة الخصوصية",
  "Terms & Conditions": "الشروط والأحكام",
  "Weight": "الوزن",
  "Height": "الطول",
  "Gender": "الجنس",
  "No profile data found": "لم يتم العثور على بيانات الملف الشخصي",
  "Add Card Image": "إضافة صورة البطاقة",
  "Full Name": "الاسم الكامل",
  "Card Number": "رقم البطاقة",
  "Address": "العنوان",
  "Number of family members": "عدد أفراد العائلة",
  "Member Name": "اسم العضو",
  "No Appointments Found": "لا توجد مواعيد",
  "Note": "ملاحظة",
  "No Completed Appointments": "لا توجد مواعيد مكتملة",
  "No Canceled Appointments": "لا توجد مواعيد ملغاة",
  "Edit Book Appointment": "تعديل موعد الحجز",
  "No profile data found": "لم يتم العثور على بيانات الملف الشخصي",
  "No working hours available": "لا توجد ساعات عمل متاحة",
  "About": "حول",
  "Update Appointment": "تحديث الموعد",
  "Error": "خطأ",
  "Please select a date and time": "يرجى تحديد التاريخ والوقت",
  "Book Appointment": "حجز موعد",
  "Create Appointment": "إنشاء موعد",
  "Update Appointment": "تحديث الموعد",
  "No Services Available": "لا توجد خدمات متاحة",
  "Confirm Logout": "تأكيد تسجيل الخروج",
  "Language": "اللغة",
  "Privacy & Policy": "الخصوصية والسياسة",
  "Terms & Condition": "الشروط والأحكام",
  "Are you sure you want to log out?": "هل أنت متأكد أنك تريد تسجيل الخروج؟",
  "No": "لا",
  "Yes": "نعم",
  "Log out": "تسجيل الخروج",
  "The code was sent successfully":"تم إرسال الرمز بنجاح",
  "Alert":"تنبيه",
  "No data was modified":"لم يتم تعديل أي بيانات",
  "Success": "نجاح",
  "The appointment was updated successfully": "تم تحديث الموعد بنجاح",
  "An error occurred while updating the appointment":"حدث خطأ أثناء تحديث الموعد",
  "Unknown error":"خطأ غير معروف",
  "The code was sent successfully":"تم إرسال الرمز بنجاح",
  "An error occurred while sending the code": "حدث خطأ أثناء إرسال الرمز",
  "Unknown error": "خطأ غير معروف",
  "The code was sent successfully": "تم إرسال الرمز بنجاح",
  "An error occurred while sending the code": "حدث خطأ أثناء إرسال الرمز",
  "App Information": "معلومات التطبيق",
  "Contact Us": "اتصل بنا",
  'Get in Touch': 'تواصل معنا',
  'your_name': 'اسمك',
  'your_email': 'بريدك الإلكتروني',
  'your_message': 'رسالتك',
  'send_message': 'إرسال الرسالة',
  'contact_info': 'معلومات الاتصال',
  'phone': 'رقم الهاتف',
  'email': 'البريد الإلكتروني',
  'location': 'الموقع',
  'Please enter your name': 'يرجى إدخال اسمك',
  'Please enter a valid email': 'يرجى إدخال بريد إلكتروني صالح',
  'Please enter your message': 'يرجى إدخال رسالتك',
  'success_message': 'تم إرسال الرسالة بنجاح!',
  "Services of Card":"خدمات البطاقة",
  'Phone Number':'رقم الهاتف',
  "Featured Services":"الخدمات المميزة",
  "Available Hours":"الساعات المتاحة",
  "Available Days":"الأيام المتاحة",
      'Search Services':'البحث عن الخدمات',
  "Price":"التكلفة"
}
;

