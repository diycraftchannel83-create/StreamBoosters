# StreamBoosters

Android-first organic music promotion and analytics toolkit for multiple artists.

## MVP scope
- Multi-artist catalog with Spotify track links
- Organic campaign planning and shareable Spotify links
- Campaign click tracking (requires backend in a later phase)
- Manual import of official reports for stream metrics
- Dashboard that clearly distinguishes link clicks from verified streams

## Compliance and data integrity
- No automated/repeated playback, stream manipulation, or artificial engagement.
- Spotify integration must use approved OAuth/API scopes and comply with current Spotify Developer Policy.
- Do not claim clicks are streams. Stream counts should come from authorized official reports or supported official data sources.
- Keep client secrets and access tokens out of source control.

## Planned stack
- Flutter / Dart Android app
- Laravel REST API
- PostgreSQL
- Spotify OAuth with PKCE where supported and approved
- GitHub Actions for Android build automation

## Current status
Initial repository scaffold. Spotify API access, backend services, campaign attribution, and report import need to be implemented and tested before production use.

## Build
Install Flutter stable, then run:
```bash
flutter pub get
flutter analyze
flutter run
```
