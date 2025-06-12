class MyAppValidators {
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-z]{2,7}$',
    ).hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // Phone Number Validator
  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number';
    }
    return null;
  }

  // OTP Validator
  String? validateOtp(String? value) {
    if (value == null || value.isEmpty) {
      return 'OTP is required';
    } else if (value.length != 6) {
      return 'Please enter a valid 6-digit OTP';
    }
    return null;
  }

  // Password Validator
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateNames(String? value, {required String name}) {
    if (value == null || value.isEmpty) {
      return 'Enter the $name';
    }
    return null;
  }

  

  String? validateArea(String? value) {
    if (value == null || value.isEmpty) {
      return 'Area is required';
    }

    final numValue = num.tryParse(value);
    if (numValue == null) {
      return 'Enter a valid number';
    } else if (numValue <= 0) {
      return 'Area must be greater than 0';
    }

    return null;
  }

  String? validateRoomDimensions(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Room dimensions are required';
    }

    final pattern = RegExp(r'^\d+\s*x\s*\d+\s*ft$', caseSensitive: false);
    if (!pattern.hasMatch(value.trim())) {
      return 'Enter in format: e.g., 15 x 16 ft';
    }

    return null;
  }

  String? validateNumberOfBeds(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Number of beds is required';
    }

    final intValue = int.tryParse(value.trim());
    if (intValue == null) {
      return 'Enter a valid number';
    } else if (intValue <= 0) {
      return 'Number of beds must be at least 1';
    }

    return null;
  }

  String? validateAmount(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Amount is required';
  }

  final intValue = int.tryParse(value.trim());
  if (intValue == null) {
    return 'Enter a valid amount';
  } else if (intValue <= 0) {
    return 'Amount must be greater than 0';
  }

  return null;
}

}
