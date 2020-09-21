# UK Citizenship Test (Life in the UK Test)

The Life in the United Kingdom test is a computer-based test constituting one of the requirements for anyone seeking Indefinite Leave to Remain in the UK or naturalisation as a British citizen. It is meant to prove that the applicant has a sufficient knowledge of British life and sufficient proficiency in the English 

This app is an exam preparation aid for this test. It has been implemented in flutter and can be run on both iOS and Android

![ios app banner](https://github.com/edwinbosire/citizenship_test_flutter/blob/main/github_resources/ios_app_anner.png?raw=true)

I've done this before, I've written this app before in React-Native [read about it here](https://medium.com/@edwinbosire/an-app-in-24-hours-my-react-native-experience-dda6cbc5da7). I've also written it in Objective-c and Swift, but here we are again

### Attack plan
1. Start a quiz and complete and attempt all questions
- [x] scroll back to answered questions and not go forward
- [x] scroll to the next question automatically when the current one is answered correctly
- [x] show hint for a questions once you've answered it incorrectly
- [ ] if a user requests for the hint and no answeres selected, mark the question as wrong, then display the hint
- [ ] allow the user to save a question in favourites
- [x] stop users from amending previous questions

2. Present results page once all questions are answered.
- [x] show a score in percentage that is correct answers / total questions
- [x] show a list of answered questions, highlighting questions users have selected overlayed with the correct colors

3. Allow users to see a list of possible quizes, if a quiz has been attemted, show the score

*** We need a way to persist data, we can use UserPreferences for now, or upgrade to SQLite database ***

4. Allow user to read the revision material (Book)
- [ ] table of content with progress bar
- [ ] allow user to dive deeper into the content of the book
- [ ] track reading progress


Nice to have:
- Have questions per book section
- Show scores per book section, this could help the user focus on a particular topic
- Flash card with notes derived from the book.

Technicals

- [x] move all relevant state from the model objects to ExamViewModel and QuestionViewModel, this will allow us to reset an exam
- [x] employ the use of Provider package to accomplish the above.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
