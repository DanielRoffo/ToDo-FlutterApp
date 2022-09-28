import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class AuthRepository{
  // Sign in

  Future<String> fetchUserIdFromAttributes() async{
    final attributes = await Amplify.Auth.fetchUserAttributes();
    final subAttribute = attributes.firstWhere((element) => element.userAttributeKey == 'sub');
    final userId = subAttribute.value;
    return userId;
  }

  Future<String> webSignIn() async{
    try{
      final result = await Amplify.Auth.signInWithWebUI();
      if (result.isSignedIn) {
        // get user id
        return await fetchUserIdFromAttributes();
      }
      else{
        throw Exception('could not sign in');
      }
    }catch(e) {
      throw e;
    }

    return "";
  }


  // Sign out

  Future<void> signOut() async {
    try{
      await Amplify.Auth.signOut();
    }catch(e){
      throw e;
    }
  }

  // Auto sign in

  Future<String> attemptAutoSignIn() async{
    try{
      return await fetchUserIdFromAttributes();
    }catch(e){
      throw e;
    }
  }
}