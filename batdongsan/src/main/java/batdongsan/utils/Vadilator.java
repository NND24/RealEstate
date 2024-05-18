package batdongsan.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Vadilator {
	public static boolean isValidEmail(String email) {
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        Pattern pattern = Pattern.compile(emailRegex);
        Matcher matcher = pattern.matcher(email);
        return matcher.matches();
    }

    public static boolean isValidPhoneNumber(String phoneNumber) {
        String phoneRegex = "^(03[2-9]|05[6-9]|07[0|6-9]|08[1-9]|09[0-9]|01[2-9])[0-9]{7}$";
        Pattern pattern = Pattern.compile(phoneRegex);
        Matcher matcher = pattern.matcher(phoneNumber);
        return matcher.matches();
    }

    public static boolean isValidCccd(String cccdNumber) {
        // Kiểm tra chiều dài của số CCCD
        if (cccdNumber.length() != 9 && cccdNumber.length() != 12) {
            return false;
        }

        // Kiểm tra xem số CCCD có chứa chỉ chữ số không
        if (!cccdNumber.matches("\\d+")) {
            return false;
        }

        // Các điều kiện khác tùy thuộc vào quy tắc cụ thể của số CCCD
        // Bạn có thể cần thay đổi hàm này tùy thuộc vào yêu cầu cụ thể
        return true;
    }

    public static boolean isValidBhyt(String soTheBHYT) {
        // Tạo biểu thức chính quy để kiểm tra mã số BHYT
        String regex = "^[0-9]{2}[0-9]{2}[0-9]{6}$";

        // Kiểm tra xem mã số BHYT có đúng định dạng hay không
        boolean isVaild = Pattern.matches(regex, soTheBHYT);

        if (isVaild) {
            return true;
        } else {
            return false;
        }
    }

    
    public static boolean isIntegerString(String input) {
        String regex = "^\\d+$";

        return Pattern.matches(regex, input);
    }
}
