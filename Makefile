generate:
	fvm flutter packages pub run build_runner build --delete-conflicting-outputs
clean:
	fvm flutter clean
get:
	fvm flutter pub get
setup:
	make get && make generate
upgrade:
	fvm flutter pub upgrade --major-versions
fix:
	fvm dart fix --apply
