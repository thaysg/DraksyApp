import 'package:equatable/equatable.dart';

import 'exceptions.dart' show AppException;

// ─────────────────────────────────────────────────────────────────────────────
// BASE
// ─────────────────────────────────────────────────────────────────────────────

/// Base class for all application failures.
/// Used in Clean Architecture to represent domain layer errors.
/// Failures are the domain-facing counterpart to data-layer [AppException]s.
abstract class Failure extends Equatable {
  /// Creates a failure with a human-readable message.
  const Failure(this.message);

  /// Human-readable error message safe to display in the UI.
  final String message;

  @override
  List<Object?> get props => [message];

  @override
  String toString() => message;
}

// ─────────────────────────────────────────────────────────────────────────────
// NETWORK
// ─────────────────────────────────────────────────────────────────────────────

/// Base class for all network-related failures.
class NetworkFailure extends Failure {
  /// Creates a generic network failure.
  const NetworkFailure(super.message);
}

/// Represents the absence of an internet connection.
class NoInternetFailure extends NetworkFailure {
  /// Creates a no-internet failure.
  const NoInternetFailure([
    super.message = 'No internet connection. Please check your network.',
  ]);
}

/// Represents a request that exceeded the allowed time limit.
class NetworkTimeoutFailure extends NetworkFailure {
  /// Creates a network timeout failure.
  const NetworkTimeoutFailure([
    super.message = 'The request timed out. Please try again.',
  ]);
}

/// Represents a server that actively refused the connection.
class ConnectionRefusedFailure extends NetworkFailure {
  /// Creates a connection refused failure.
  const ConnectionRefusedFailure([
    super.message = 'Connection refused by the server.',
  ]);
}

/// Represents an SSL/TLS certificate validation failure.
class SslFailure extends NetworkFailure {
  /// Creates an SSL failure.
  const SslFailure([
    super.message = 'Secure connection failed. SSL certificate error.',
  ]);
}

/// Represents an unexpected or malformed response from the server.
class BadResponseFailure extends NetworkFailure {
  /// Creates a bad response failure.
  const BadResponseFailure(super.message);
}

// ─────────────────────────────────────────────────────────────────────────────
// AUTHENTICATION
// ─────────────────────────────────────────────────────────────────────────────

/// Base class for all authentication-related failures.
class AuthFailure extends Failure {
  /// Creates a generic auth failure.
  const AuthFailure(super.message);
}

/// Represents incorrect email or password credentials.
class InvalidCredentialsFailure extends AuthFailure {
  /// Creates an invalid credentials failure.
  const InvalidCredentialsFailure([
    super.message = 'Invalid email or password.',
  ]);
}

/// Represents an expired access token.
class TokenExpiredFailure extends AuthFailure {
  /// Creates a token expired failure.
  const TokenExpiredFailure([
    super.message = 'Your session has expired. Please sign in again.',
  ]);
}

/// Represents a malformed or invalid token.
class TokenInvalidFailure extends AuthFailure {
  /// Creates a token invalid failure.
  const TokenInvalidFailure([
    super.message = 'Invalid authentication token.',
  ]);
}

/// Represents a server-side session that no longer exists.
class SessionExpiredFailure extends AuthFailure {
  /// Creates a session expired failure.
  const SessionExpiredFailure([
    super.message = 'Session expired. Please sign in again.',
  ]);
}

/// Represents a sign-in attempt with an unconfirmed email address.
class EmailNotConfirmedFailure extends AuthFailure {
  /// Creates an email not confirmed failure.
  const EmailNotConfirmedFailure([
    super.message = 'Please confirm your email address before signing in.',
  ]);
}

/// Represents a sign-in attempt with an unconfirmed phone number.
class PhoneNotConfirmedFailure extends AuthFailure {
  /// Creates a phone not confirmed failure.
  const PhoneNotConfirmedFailure([
    super.message = 'Please confirm your phone number before signing in.',
  ]);
}

/// Represents a user that does not exist in the system.
class UserNotFoundFailure extends AuthFailure {
  /// Creates a user not found failure.
  const UserNotFoundFailure([super.message = 'User not found.']);
}

/// Represents a registration attempt with an already-used email.
class UserAlreadyExistsFailure extends AuthFailure {
  /// Creates a user already exists failure.
  const UserAlreadyExistsFailure([
    super.message = 'An account with this email already exists.',
  ]);
}

/// Represents a password that does not meet security requirements.
class WeakPasswordFailure extends AuthFailure {
  /// Creates a weak password failure.
  const WeakPasswordFailure([
    super.message = 'Password is too weak.'
        '\nUse at least 8 characters, including letters and numbers.',
  ]);
}

/// Represents a user lacking authorization for the requested action.
class UnauthorizedFailure extends AuthFailure {
  /// Creates an unauthorized failure.
  const UnauthorizedFailure([
    super.message = 'You are not authorized to perform this action.',
  ]);
}

/// Represents a disabled or permanently deleted account.
class AccountDisabledFailure extends AuthFailure {
  /// Creates an account disabled failure.
  const AccountDisabledFailure([
    super.message = 'This account has been disabled. Please contact support.',
  ]);
}

/// Represents too many authentication attempts in a short time window.
class AuthRateLimitFailure extends AuthFailure {
  /// Creates an auth rate limit failure.
  const AuthRateLimitFailure([
    super.message = 'Too many attempts. Please wait a moment and try again.',
  ]);
}

/// Represents an error returned by an OAuth provider.
class OAuthFailure extends AuthFailure {
  /// Creates an OAuth failure.
  const OAuthFailure(super.message, {this.provider});

  /// The name of the provider that failed (e.g., 'Google', 'Apple').
  final String? provider;

  @override
  List<Object?> get props => [message, provider];
}

/// Represents a flow that requires multi-factor authentication.
class MfaRequiredFailure extends AuthFailure {
  /// Creates an MFA required failure.
  const MfaRequiredFailure([
    super.message = 'Multi-factor authentication is required.',
  ]);
}

/// Represents an invalid or expired MFA verification code.
class InvalidMfaCodeFailure extends AuthFailure {
  /// Creates an invalid MFA code failure.
  const InvalidMfaCodeFailure([
    super.message = 'Invalid or expired verification code.',
  ]);
}

/// Represents an expired or already-used password reset link.
class PasswordResetExpiredFailure extends AuthFailure {
  /// Creates a password reset expired failure.
  const PasswordResetExpiredFailure([
    super.message =
        'Password reset link has expired. Please request a new one.',
  ]);
}

// ─────────────────────────────────────────────────────────────────────────────
// DATABASE
// ─────────────────────────────────────────────────────────────────────────────

/// Base class for all database-related failures.
class DatabaseFailure extends Failure {
  /// Creates a generic database failure.
  const DatabaseFailure(super.message);
}

/// Represents a call to a database RPC function that does not exist.
/// Maps to a remote data source error.
class RpcNotFoundFailure extends DatabaseFailure {
  /// Creates an RPC not found failure.
  const RpcNotFoundFailure(
    super.message, {
    this.functionName,
  });

  /// The name of the RPC function that was not found.
  final String? functionName;

  @override
  List<Object?> get props => [message, functionName];
}

/// Represents a violation of a database constraint (unique, check, not-null).
class ConstraintViolationFailure extends DatabaseFailure {
  /// Creates a constraint violation failure.
  const ConstraintViolationFailure(super.message);
}

/// Represents a duplicate key violation on a unique index.
class DuplicateKeyFailure extends DatabaseFailure {
  /// Creates a duplicate key failure.
  const DuplicateKeyFailure([
    super.message = 'A record with this value already exists.',
  ]);
}

/// Represents a foreign key constraint violation.
class ForeignKeyViolationFailure extends DatabaseFailure {
  /// Creates a foreign key violation failure.
  const ForeignKeyViolationFailure([
    super.message = 'Operation failed due to a related record dependency.',
  ]);
}

/// Represents a failed and rolled-back database transaction.
class TransactionFailure extends DatabaseFailure {
  /// Creates a transaction failure.
  const TransactionFailure([
    super.message = 'Database transaction failed and was rolled back.',
  ]);
}

/// Represents a query that returned no results when at least one was expected.
class EmptyResultFailure extends DatabaseFailure {
  /// Creates an empty result failure.
  const EmptyResultFailure([
    super.message = 'No records found for the given query.',
  ]);
}

/// Represents a reference to a database table or view that does not exist.
class TableNotFoundFailure extends DatabaseFailure {
  /// Creates a table not found failure.
  const TableNotFoundFailure([
    super.message = 'The requested database table was not found.',
  ]);
}

// ─────────────────────────────────────────────────────────────────────────────
// SERVER
// ─────────────────────────────────────────────────────────────────────────────

/// Base class for all server/API-related failures.
class ServerFailure extends Failure {
  /// Creates a generic server failure.
  const ServerFailure(super.message, {this.statusCode});

  /// HTTP status code returned by the server.
  final int? statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

/// Represents a 500 Internal Server Error.
class InternalServerFailure extends ServerFailure {
  /// Creates an internal server failure.
  const InternalServerFailure([
    super.message = 'Internal server error. Please try again later.',
  ]) : super(statusCode: 500);
}

/// Represents a 503 Service Unavailable response.
class ServiceUnavailableFailure extends ServerFailure {
  /// Creates a service unavailable failure.
  const ServiceUnavailableFailure([
    super.message =
        'Service is temporarily unavailable. Please try again later.',
  ]) : super(statusCode: 503);
}

/// Represents a 502 Bad Gateway response.
class BadGatewayFailure extends ServerFailure {
  /// Creates a bad gateway failure.
  const BadGatewayFailure([
    super.message = 'Bad gateway. The server received an invalid response.',
  ]) : super(statusCode: 502);
}

/// Represents a 504 Gateway Timeout response.
class GatewayTimeoutFailure extends ServerFailure {
  /// Creates a gateway timeout failure.
  const GatewayTimeoutFailure([
    super.message = 'Gateway timeout. The server took too long to respond.',
  ]) : super(statusCode: 504);
}

/// Represents a 429 Too Many Requests response.
class ServerRateLimitFailure extends ServerFailure {
  /// Creates a server rate limit failure.
  const ServerRateLimitFailure([
    super.message = 'Too many requests. Please slow down and try again.',
  ]) : super(statusCode: 429);
}

/// Represents a 404 Not Found at the API endpoint level.
class ApiEndpointNotFoundFailure extends ServerFailure {
  /// Creates an API endpoint not found failure.
  const ApiEndpointNotFoundFailure([
    super.message = 'The requested API endpoint was not found.',
  ]) : super(statusCode: 404);
}

/// Represents a 403 Forbidden response.
class ForbiddenFailure extends ServerFailure {
  /// Creates a forbidden failure.
  const ForbiddenFailure([
    super.message = 'You do not have permission to access this resource.',
  ]) : super(statusCode: 403);
}

// ─────────────────────────────────────────────────────────────────────────────
// CACHE / LOCAL STORAGE
// ─────────────────────────────────────────────────────────────────────────────

/// Base class for all local cache/storage failures.
class CacheFailure extends Failure {
  /// Creates a generic cache failure.
  const CacheFailure(super.message);
}

/// Represents a failure when reading from the local cache.
class CacheReadFailure extends CacheFailure {
  /// Creates a cache read failure.
  const CacheReadFailure([
    super.message = 'Failed to read data from local cache.',
  ]);
}

/// Represents a failure when writing to the local cache.
class CacheWriteFailure extends CacheFailure {
  /// Creates a cache write failure.
  const CacheWriteFailure([
    super.message = 'Failed to write data to local cache.',
  ]);
}

/// Represents a cache miss where the requested entry does not exist.
class CacheNotFoundFailure extends CacheFailure {
  /// Creates a cache not found failure.
  const CacheNotFoundFailure([
    super.message = 'Requested data was not found in local cache.',
  ]);
}

/// Represents corrupted or unreadable local cache data.
class CacheCorruptedFailure extends CacheFailure {
  /// Creates a cache corrupted failure.
  const CacheCorruptedFailure([
    super.message = 'Local cache data is corrupted.',
  ]);
}

/// Represents a full local storage with no space remaining.
class CacheQuotaExceededFailure extends CacheFailure {
  /// Creates a cache quota exceeded failure.
  const CacheQuotaExceededFailure([
    super.message = 'Local storage quota exceeded. Please free up space.',
  ]);
}

// ─────────────────────────────────────────────────────────────────────────────
// STORAGE (FILE / MEDIA)
// ─────────────────────────────────────────────────────────────────────────────

/// Base class for all remote file storage failures.
class StorageFailure extends Failure {
  /// Creates a generic storage failure.
  const StorageFailure(super.message);
}

/// Represents a failed file upload.
class UploadFailure extends StorageFailure {
  /// Creates an upload failure.
  const UploadFailure([
    super.message = 'File upload failed. Please try again.',
  ]);
}

/// Represents a failed file download.
class DownloadFailure extends StorageFailure {
  /// Creates a download failure.
  const DownloadFailure([
    super.message = 'File download failed. Please try again.',
  ]);
}

/// Represents a file that exceeds the maximum allowed upload size.
class FileTooLargeFailure extends StorageFailure {
  /// Creates a file too large failure.
  const FileTooLargeFailure([
    super.message = 'File exceeds the maximum allowed size.',
  ]);
}

/// Represents a rejected file type.
class InvalidFileTypeFailure extends StorageFailure {
  /// Creates an invalid file type failure.
  const InvalidFileTypeFailure([
    super.message = 'File type is not allowed.',
  ]);
}

/// Represents a missing storage bucket.
class BucketNotFoundFailure extends StorageFailure {
  /// Creates a bucket not found failure.
  const BucketNotFoundFailure([super.message = 'Storage bucket not found.']);
}

/// Represents an attempt to overwrite an already existing file.
class FileAlreadyExistsFailure extends StorageFailure {
  /// Creates a file already exists failure.
  const FileAlreadyExistsFailure([
    super.message = 'A file with this name already exists.',
  ]);
}

// ─────────────────────────────────────────────────────────────────────────────
// VALIDATION
// ─────────────────────────────────────────────────────────────────────────────

/// Base class for all input validation failures.
class ValidationFailure extends Failure {
  /// Creates a generic validation failure.
  const ValidationFailure(super.message, {this.field});

  /// The name of the field that failed validation, if applicable.
  final String? field;

  @override
  List<Object?> get props => [message, field];
}

/// Represents an empty or null required field.
class RequiredFieldFailure extends ValidationFailure {
  /// Creates a required field failure.
  const RequiredFieldFailure({
    required String field,
    String message = 'This field is required.',
  }) : super(message, field: field);
}

/// Represents a value that does not match the expected format.
class InvalidFormatFailure extends ValidationFailure {
  /// Creates an invalid format failure.
  const InvalidFormatFailure(super.message, {super.field});
}

/// Represents a value whose length is outside the allowed range.
class LengthFailure extends ValidationFailure {
  /// Creates a length failure.
  const LengthFailure(super.message, {super.field});
}

/// Represents a numeric value outside the allowed range.
class RangeFailure extends ValidationFailure {
  /// Creates a range failure.
  const RangeFailure(super.message, {super.field});
}

/// Represents two values that must match but do not
///  (e.g., password confirmation).
class MismatchFailure extends ValidationFailure {
  /// Creates a mismatch failure.
  const MismatchFailure([
    super.message = 'The values do not match.',
  ]);
}

// ─────────────────────────────────────────────────────────────────────────────
// PARSING / SERIALIZATION
// ─────────────────────────────────────────────────────────────────────────────

/// Base class for all parsing and serialization failures.
class ParseFailure extends Failure {
  /// Creates a generic parse failure.
  const ParseFailure(super.message);
}

/// Represents a JSON string that could not be decoded.
class JsonParseFailure extends ParseFailure {
  /// Creates a JSON parse failure.
  const JsonParseFailure([
    super.message = 'Failed to parse server response. Unexpected format.',
  ]);
}

/// Represents a value that could not be cast to the expected Dart type.
class TypeMismatchFailure extends ParseFailure {
  /// Creates a type mismatch failure.
  const TypeMismatchFailure([
    super.message = 'Unexpected data type received from the server.',
  ]);
}

/// Represents a required field missing from the parsed data.
class MissingFieldFailure extends ParseFailure {
  /// Creates a missing field failure.
  const MissingFieldFailure([
    super.message = 'A required field is missing from the server response.',
  ]);
}

// ─────────────────────────────────────────────────────────────────────────────
// PERMISSION
// ─────────────────────────────────────────────────────────────────────────────

/// Base class for all device permission failures.
class PermissionFailure extends Failure {
  /// Creates a generic permission failure.
  const PermissionFailure(super.message);
}

/// Represents a denied device permission (camera, location, etc.).
class DevicePermissionDeniedFailure extends PermissionFailure {
  /// Creates a device permission denied failure.
  const DevicePermissionDeniedFailure([
    super.message =
        'Permission denied. Please grant access in your device settings.',
  ]);
}

/// Represents a permanently denied device permission.
class DevicePermissionPermanentlyDeniedFailure extends PermissionFailure {
  /// Creates a device permission permanently denied failure.
  const DevicePermissionPermanentlyDeniedFailure([
    super.message = 'Permission permanently denied.'
        '\nPlease enable it in your device settings.',
  ]);
}

// ─────────────────────────────────────────────────────────────────────────────
// RESOURCE
// ─────────────────────────────────────────────────────────────────────────────

/// Represents a specific resource (record, file, user) that could not be found.
class NotFoundFailure extends Failure {
  /// Creates a not found failure.
  const NotFoundFailure(super.message);
}

// ─────────────────────────────────────────────────────────────────────────────
// BUSINESS LOGIC
// ─────────────────────────────────────────────────────────────────────────────

/// Represents a violation of a business rule or domain constraint.
class BusinessRuleFailure extends Failure {
  /// Creates a business rule failure.
  const BusinessRuleFailure(super.message);
}

/// Represents an operation that is not allowed in the current app state.
class InvalidOperationFailure extends Failure {
  /// Creates an invalid operation failure.
  const InvalidOperationFailure(super.message);
}

// ─────────────────────────────────────────────────────────────────────────────
// UNKNOWN
// ─────────────────────────────────────────────────────────────────────────────

/// Represents a failure whose type could not be determined.
class UnknownFailure extends Failure {
  /// Creates an unknown failure.
  const UnknownFailure(super.message);
}
