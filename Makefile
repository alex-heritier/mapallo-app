
.PHONY: android ios models fix

models:
	flutter packages pub run build_runner build --delete-conflicting-outputs

android:
	flutter clean
	flutter build appbundle -v --target-platform=android-arm64

ios:
	flutter clean
	flutter build ios --release -v
