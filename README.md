# Pretty Dialog

A package to use for dialogs and toasts in Flutter Apps

## Usage

### Alert Dialog

```dart
PrettyDialog.showAlertDialog(
    context,
    alertType: AlertType.success,
    okText: "OK",
    title: "Your account is created successfully",
);
```

### Action Dialog

```dart
var result = await PrettyDialog.showActionDialog(context,
    icon: CupertinoIcons.person_crop_circle_badge_xmark,
    iconColor: Colors.deepOrangeAccent,
    yesText: "Yes, Delete",
    yesColor: Colors.deepOrangeAccent,
    cancelText: "No",
    // you can set noText, but cancel text will create outlined button
    title: "Are you sure to delete your Account?",
    subTitle: "All your data will be permanently deleted, This can't be undone"
);
// result will be `true` for Yes button, `false` for No and `null` for Cancel
```

### Options Dialog

```dart
var result = await PrettyDialog.showOptionsDialog(context,
    icon: FontAwesomeIcons.dumbbell,
    title: "لماذا تمارس التمارين الرياضية؟",
    options: [
"لبناء العضلات",      
"لإنقاص الوزن",      
      "للحفاظ على الصحة بشكل عام",
    ]);
// result is an integer, the index of the selected option
```

### Toast

```dart
PrettyToast.showErrorToast(context, "Something Went Wrong!");
```

### Progress Toast

```dart
PrettyToast.showProgressToast(context, text: "جاري العمل ...");
Future.delayed(const Duration(seconds: 3), () => PrettyToast.hideProgressToast());
```