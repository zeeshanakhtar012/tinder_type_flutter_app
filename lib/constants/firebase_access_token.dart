import 'dart:developer';

import 'package:googleapis_auth/auth_io.dart';

class FirebaseAccessToken {
  static String firebaseMessagingApi =
      "https://www.googleapis.com/auth/firebase.messaging";

  Future<String> generateFirebaseAccessToken() async {
    final credentialsJson = {
      "type": "service_account",
      "project_id": "blaxity-8bddb",
      "private_key_id": "0ba83d5f7a360049a6bc0aa52f62ed1f05090fe2",
      "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC5YnR9sX4uRyJN\nMQ4KcFw6ugeyg4UmcFYXKfRMTniT+WhRdWpHFLhr1bDwM3qdaNg0Z9htg++exL9I\nJbZUhPcJjnROQQvK8TQVhCWZjQI7jprETWlRcm+DSYWRQef/TC+/TZVkdGp1/dO/\nbpPwPdYSoLNGuIezV3egSpGRuJgUx5TB7dgvGH9PQvSZ+wzOl7f3qBMZqSSIQ07F\no2llNxwlmNx30YkPwvgrAiuUyDDDGzS6uOOMXcnCUGhmVjA9VLaq7pzB4Rt/CZ8S\naOmjWf5ThRT/HDuNXe97S21HGZT3iS25NHlqppUk8tlFMyinP0VugUibEvQNE8Hp\nro+p+lYrAgMBAAECggEABUT3UwlOsQm5lQseFI2MDulHGxEM9wI+GDYg6Q2un2TO\nonNyxrwf39ojnOLsYHlgnTYPG1HNklbnqakqF8NDHa+XE7sFQZ/93yyx6uhCANJg\nCNC7JnhZE24YEKsYaT56Tvbpa6u5c6Ai5YVC9D21uN1+KwucuSwfzNvBwSwc5TOY\nsxGihCqSlkVMHvBROBDnbwniCGtBZ4O2XLtCKb4uZjQ/yjX06dqOC8ZZDw1HS+C9\n0ESwTbZ39qhYVyxPw9Q4rYwtuEPzTSvhJlInVP2HYAMCuxbrvmgvSTNraUlEHes6\nhpafupQDTW9SkBcwNZCISOMmJWOyIn2+Qufe2z4LjQKBgQDf4Ok/qLBJzhpNl/8w\nLvaJzqu6T7oTX+LX3F7Ki1v6z4BbIdEnn05Ikx13cN7+ZOuUKMujOLvtgdA3E+7N\nJQAgBUtiXImvxXoTN8KLCgfGNf9icWZaa8baypUwGJKDp+uvlXomZ6haFTfVbfHO\nEIU6eL2HEocClmG2PPrOJ2W0lwKBgQDT+6fGwAWSW1Bn8WjjDYHHWeNwrqNkmzmo\nqrM9QZCI4QMXNBeiWlWv+7OS/SI0BLeVQQdl4VNvZNpju0LdClxaHsBwpAG//tgK\nKn966V4UQ8PZVucfl3cC6NJfcOcGy6PA0NzjjhpOAqhwpcsmZrWTBZm+wbbcwWcd\nPptH9wn5jQKBgHKTJEwUBMSA2i1D0LHUFxBH2NMs4knwFKPsgAagc55Ue5goImZo\nvSOfRsFN3pHLDFVy22TZMDRI70qAxQHwIbRBgWcBfOWb5vHW45VMuNXT5LN43a0A\n43AtpVRL/w+p7JCbqzvkaOBRY5WzAsE26zgVesmZzcahN7iQVLsUppRZAoGAXOjL\nnDzFNGR5VVVllz5wRyOKn/SrAIlYOCi47nwyEQwuApl+UlYtgDhdeGsh9pKqs+wQ\nhgLAQu59GYEVyTOlTopz5eq8KZ5Uqf/+Z6yo41DgIf4IxrvoGYpZyiL93uiaGQRy\nC/pYZSCdGuJPq8EQjCPEQus8bn0F6Ldr75rC8HECgYEAgThbmq7xuDo+Ky4HDg1r\nngmU/0rHgzKeyaeO4hOFLR69Ycg7AiNb4Cv+MlcfNNl2AWXhDlUU0KoPA8Cs9Qz8\nT8QvmHmwJZgFsIscnFX+nBZWEo8e5UcVECzJcuLDACTrUpsImkeUZeeII1IDwFNg\nGouz9PA2G4z3rFxKxkQaSN4=\n-----END PRIVATE KEY-----\n",
      "client_email": "firebase-adminsdk-bzl8q@blaxity-8bddb.iam.gserviceaccount.com",
      "client_id": "102051393021797355073",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-bzl8q%40blaxity-8bddb.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    try {
      final client = await clientViaServiceAccount(
          ServiceAccountCredentials.fromJson(credentialsJson),
          [firebaseMessagingApi]);
      final accessToken = client.credentials.accessToken.data;
      log('OAuth 2.0 access token generated: $accessToken');
      return accessToken;
    } catch (e) {
      log('Error generating access token: $e');
      return '';
    }
  }
}