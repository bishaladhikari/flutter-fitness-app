import 'package:ecapp/models/SearchSuggestion.dart';

class SearchSuggestionResponse {

  List<SearchSuggestion> suggestions;
  final String error;

  SearchSuggestionResponse(this.suggestions, this.error);

  SearchSuggestionResponse.fromJson(Map<String, dynamic> json)
      : suggestions = (json["data"] as List)
            .map((i) => new SearchSuggestion.fromJson(i))
            .toList(),
        error = null;

  SearchSuggestionResponse.withError(String errorValue)
      : suggestions = List(),
        error = errorValue;
}
