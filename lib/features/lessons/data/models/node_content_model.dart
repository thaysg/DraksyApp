import 'package:equatable/equatable.dart';

/// Represents an option in a multiple-choice question.
final class QuestionOptionModel extends Equatable {
  const QuestionOptionModel({
    required this.text,
    required this.emoji,
  });

  factory QuestionOptionModel.fromJson(Map<String, dynamic> json) =>
      QuestionOptionModel(
        text: json['text'] as String,
        emoji: json['emoji'] as String,
      );

  final String text;
  final String emoji;

  Map<String, dynamic> toJson() => {
        'text': text,
        'emoji': emoji,
      };

  @override
  List<Object?> get props => [text, emoji];
}

/// Base sealed class for lesson node content.
sealed class NodeContentModel extends Equatable {
  const NodeContentModel();

  factory NodeContentModel.fromJson(Map<String, dynamic> json) =>
      switch (json['type'] as String) {
        'explanation' => ExplanationContentModel.fromJson(json),
        'question' => QuestionContentModel.fromJson(json),
        _ => throw ArgumentError('Unknown node type: ${json['type']}'),
      };

  Map<String, dynamic> toJson();

  @override
  List<Object?> get props => [];
}

/// Content for an explanation-type node.
final class ExplanationContentModel extends NodeContentModel {
  const ExplanationContentModel({
    required this.phrase,
    required this.translation,
    required this.contextSentence,
    required this.grammarTip,
    required this.imageKey,
  });

  factory ExplanationContentModel.fromJson(Map<String, dynamic> json) =>
      ExplanationContentModel(
        phrase: json['phrase'] as String,
        translation: json['translation'] as String,
        contextSentence: json['contextSentence'] as String,
        grammarTip: json['grammarTip'] as String,
        imageKey: json['imageKey'] as String,
      );

  final String phrase;
  final String translation;
  final String contextSentence;
  final String grammarTip;
  final String imageKey;

  @override
  Map<String, dynamic> toJson() => {
        'type': 'explanation',
        'phrase': phrase,
        'translation': translation,
        'contextSentence': contextSentence,
        'grammarTip': grammarTip,
        'imageKey': imageKey,
      };

  @override
  List<Object?> get props => [
        phrase,
        translation,
        contextSentence,
        grammarTip,
        imageKey,
      ];
}

/// Content for a question-type node.
final class QuestionContentModel extends NodeContentModel {
  const QuestionContentModel({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });

  factory QuestionContentModel.fromJson(Map<String, dynamic> json) =>
      QuestionContentModel(
        question: json['question'] as String,
        options: (json['options'] as List<dynamic>)
            .map((e) => QuestionOptionModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        correctIndex: json['correctIndex'] as int,
        explanation: json['explanation'] as String,
      );

  final String question;
  final List<QuestionOptionModel> options;
  final int correctIndex;
  final String explanation;

  @override
  Map<String, dynamic> toJson() => {
        'type': 'question',
        'question': question,
        'options': options.map((e) => e.toJson()).toList(),
        'correctIndex': correctIndex,
        'explanation': explanation,
      };

  @override
  List<Object?> get props => [
        question,
        options,
        correctIndex,
        explanation,
      ];
}
