import 'package:equatable/equatable.dart';

// ─────────────────────────────────────────────────────────────────────────────
// BASE
// ─────────────────────────────────────────────────────────────────────────────

/// Base class for all application exceptions.
/// Represents runtime errors that may occur during app execution.
abstract class AppException extends Equatable implements Exception {
  /// Creates an exception with a message and optional stack trace.
  const AppException({required this.message, this.stackTrace});

  /// Human-readable error message.
  final String message;

  /// Stack trace captured at the point of failure.
  final StackTrace? stackTrace;

  @override
  List<Object?> get props => [message, stackTrace];

  @override
  String toString() => message;
}

// ─────────────────────────────────────────────────────────────────────────────
// NETWORK
// ─────────────────────────────────────────────────────────────────────────────

/// Base class for all network-related exceptions.
class NetworkException extends AppException {
  /// Creates a generic network exception.
  const NetworkException({required super.message, super.stackTrace});
}

/// Thrown when the device has no internet connection.
class NoInternetException extends NetworkException {
  /// Creates a no-internet exception.
  const NoInternetException({
    super.message = 'No internet connection. Please check your network.',
    super.stackTrace,
  });
}

/// Thrown when a network request exceeds the allowed time limit.
class NetworkTimeoutException extends NetworkException {
  /// Creates a timeout exception.
  const NetworkTimeoutException({
    super.message = 'The request timed out. Please try again.',
    super.stackTrace,
  });
}

/// Thrown when the server actively refuses the connection.
class ConnectionRefusedException extends NetworkException {
  /// Creates a connection refused exception.
  const ConnectionRefusedException({
    super.message = 'Connection refused by the server.',
    super.stackTrace,
  });
}

/// Thrown when a SSL/TLS handshake or certificate validation fails.
class SslException extends NetworkException {
  /// Creates an SSL exception.
  const SslException({
    super.message = 'Secure connection failed. SSL certificate error.',
    super.stackTrace,
  });
}

/// Thrown when the server returns an unexpected or malformed response.
class BadResponseException extends NetworkException {
  /// Creates a bad response exception.
  const BadResponseException({required super.message, super.stackTrace});
}

// ─────────────────────────────────────────────────────────────────────────────
// AUTHENTICATION
// ─────────────────────────────────────────────────────────────────────────────

/// Base class for all authentication-related exceptions.
class AuthException extends AppException {
  /// Creates a generic auth exception.
  const AuthException({required super.message, super.stackTrace});
}

/// Thrown when the provided email or password is incorrect.
class InvalidCredentialsException extends AuthException {
  /// Creates an invalid credentials exception.
  const InvalidCredentialsException({
    super.message = 'Invalid email or password.',
    super.stackTrace,
  });
}

/// Thrown when the access token has expired and needs to be refreshed.
class TokenExpiredException extends AuthException {
  /// Creates a token expired exception.
  const TokenExpiredException({
    super.message = 'Your session has expired. Please sign in again.',
    super.stackTrace,
  });
}

/// Thrown when the provided token is malformed or invalid.
class TokenInvalidException extends AuthException {
  /// Creates a token invalid exception.
  const TokenInvalidException({
    super.message = 'Invalid authentication token.',
    super.stackTrace,
  });
}

/// Thrown when the user's session no longer exists on the server.
class SessionExpiredException extends AuthException {
  /// Creates a session expired exception.
  const SessionExpiredException({
    super.message = 'Session expired. Please sign in again.',
    super.stackTrace,
  });
}

/// Thrown when the user attempts to sign in before confirming their email.
class EmailNotConfirmedException extends AuthException {
  /// Creates an email not confirmed exception.
  const EmailNotConfirmedException({
    super.message = 'Please confirm your email address before signing in.',
    super.stackTrace,
  });
}

/// Thrown when the user attempts to sign in before confirming their phone.
class PhoneNotConfirmedException extends AuthException {
  /// Creates a phone not confirmed exception.
  const PhoneNotConfirmedException({
    super.message = 'Please confirm your phone number before signing in.',
    super.stackTrace,
  });
}

/// Thrown when the authenticated user is not found in the database.
class UserNotFoundException extends AuthException {
  /// Creates a user not found exception.
  const UserNotFoundException({
    super.message = 'User not found.',
    super.stackTrace,
  });
}

/// Thrown when trying to register with an email or username already in use.
class UserAlreadyExistsException extends AuthException {
  /// Creates a user already exists exception.
  const UserAlreadyExistsException({
    super.message = 'An account with this email already exists.',
    super.stackTrace,
  });
}

/// Thrown when the provided password does not meet security requirements.
class WeakPasswordException extends AuthException {
  /// Creates a weak password exception.
  const WeakPasswordException({
    super.message = 'Password is too weak.'
        ' \nUse at least 8 characters, including letters and numbers.',
    super.stackTrace,
  });
}

/// Thrown when the user tries to perform an action they are not authorized for.
class UnauthorizedException extends AuthException {
  /// Creates an unauthorized exception.
  const UnauthorizedException({
    super.message = 'You are not authorized to perform this action.',
    super.stackTrace,
  });
}

/// Thrown when the account has been disabled or permanently deleted.
class AccountDisabledException extends AuthException {
  /// Creates an account disabled exception.
  const AccountDisabledException({
    super.message = 'This account has been disabled. Please contact support.',
    super.stackTrace,
  });
}

/// Thrown when too many authentication attempts have been made in a short time.
class AuthRateLimitException extends AuthException {
  /// Creates an auth rate limit exception.
  const AuthRateLimitException({
    super.message = 'Too many attempts. Please wait a moment and try again.',
    super.stackTrace,
  });
}

/// Thrown when an OAuth provider (Google, Apple, etc.) returns an error.
class OAuthException extends AuthException {
  /// Creates an OAuth exception.
  const OAuthException({
    required super.message,
    super.stackTrace,
    this.provider,
  });

  /// The name of the OAuth provider that failed (e.g., 'Google', 'Apple').
  final String? provider;

  @override
  List<Object?> get props => [message, stackTrace, provider];
}

/// Thrown when multi-factor authentication is required to proceed.
class MfaRequiredException extends AuthException {
  /// Creates an MFA required exception.
  const MfaRequiredException({
    super.message = 'Multi-factor authentication is required.',
    super.stackTrace,
  });
}

/// Thrown when the MFA code provided by the user is invalid or expired.
class InvalidMfaCodeException extends AuthException {
  /// Creates an invalid MFA code exception.
  const InvalidMfaCodeException({
    super.message = 'Invalid or expired verification code.',
    super.stackTrace,
  });
}

/// Thrown when the password reset link has expired or was already used.
class PasswordResetExpiredException extends AuthException {
  /// Creates a password reset expired exception.
  const PasswordResetExpiredException({
    super.message =
        'Password reset link has expired. Please request a new one.',
    super.stackTrace,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// DATABASE
// ─────────────────────────────────────────────────────────────────────────────

/// Base class for all database-related exceptions.
class DatabaseException extends AppException {
  /// Creates a generic database exception.
  const DatabaseException({required super.message, super.stackTrace});
}

/// Thrown when a called RPC/stored function does not exist in the database.
/// Corresponds to a remote data source error.
class RpcNotFoundException extends DatabaseException {
  /// Creates an RPC not found exception.
  const RpcNotFoundException({
    super.message =
        'Technical error: deletion function not found in the database.'
            '\nPlease contact support.',
    super.stackTrace,
    this.functionName,
  });

  /// The name of the RPC function that was not found.
  final String? functionName;

  @override
  List<Object?> get props => [message, stackTrace, functionName];
}

/// Thrown when a database constraint (unique, check, not-null) is violated.
class ConstraintViolationException extends DatabaseException {
  /// Creates a constraint violation exception.
  const ConstraintViolationException({
    required super.message,
    super.stackTrace,
    this.constraintName,
  });

  /// The name of the constraint that was violated, if available.
  final String? constraintName;

  @override
  List<Object?> get props => [message, stackTrace, constraintName];
}

/// Thrown when trying to insert a record that violates a unique index.
class DuplicateKeyException extends DatabaseException {
  /// Creates a duplicate key exception.
  const DuplicateKeyException({
    super.message = 'A record with this value already exists.',
    super.stackTrace,
  });
}

/// Thrown when an operation would violate a foreign key relationship.
class ForeignKeyViolationException extends DatabaseException {
  /// Creates a foreign key violation exception.
  const ForeignKeyViolationException({
    super.message = 'Operation failed due to a related record dependency.',
    super.stackTrace,
  });
}

/// Thrown when a database transaction fails and is rolled back.
class TransactionException extends DatabaseException {
  /// Creates a transaction exception.
  const TransactionException({
    super.message = 'Database transaction failed and was rolled back.',
    super.stackTrace,
  });
}

/// Thrown when a query returns no results but at least one was expected.
class EmptyResultException extends DatabaseException {
  /// Creates an empty result exception.
  const EmptyResultException({
    super.message = 'No records found for the given query.',
    super.stackTrace,
  });
}

/// Thrown when the database table or view referenced does not exist.
class TableNotFoundException extends DatabaseException {
  /// Creates a table not found exception.
  const TableNotFoundException({
    super.message = 'The requested database table was not found.',
    super.stackTrace,
    this.tableName,
  });

  /// The name of the table that was not found.
  final String? tableName;

  @override
  List<Object?> get props => [message, stackTrace, tableName];
}

// ─────────────────────────────────────────────────────────────────────────────
// SERVER
// ─────────────────────────────────────────────────────────────────────────────

/// Base class for all server/API-related exceptions.
class ServerException extends AppException {
  /// Creates a generic server exception.
  const ServerException({
    required super.message,
    super.stackTrace,
    this.statusCode,
  });

  /// HTTP status code returned by the server.
  final int? statusCode;

  @override
  List<Object?> get props => [message, stackTrace, statusCode];
}

/// Thrown when the server returns a 500 Internal Server Error.
class InternalServerException extends ServerException {
  /// Creates an internal server exception.
  const InternalServerException({
    super.message = 'Internal server error. Please try again later.',
    super.stackTrace,
    super.statusCode = 500,
  });
}

/// Thrown when the server returns a 503 Service Unavailable.
class ServiceUnavailableException extends ServerException {
  /// Creates a service unavailable exception.
  const ServiceUnavailableException({
    super.message =
        'Service is temporarily unavailable. Please try again later.',
    super.stackTrace,
    super.statusCode = 503,
  });
}

/// Thrown when the server returns a 502 Bad Gateway.
class BadGatewayException extends ServerException {
  /// Creates a bad gateway exception.
  const BadGatewayException({
    super.message = 'Bad gateway. The server received an invalid response.',
    super.stackTrace,
    super.statusCode = 502,
  });
}

/// Thrown when the server returns a 504 Gateway Timeout.
class GatewayTimeoutException extends ServerException {
  /// Creates a gateway timeout exception.
  const GatewayTimeoutException({
    super.message = 'Gateway timeout. The server took too long to respond.',
    super.stackTrace,
    super.statusCode = 504,
  });
}

/// Thrown when the server returns a 429 Too Many Requests.
class ServerRateLimitException extends ServerException {
  /// Creates a server rate limit exception.
  const ServerRateLimitException({
    super.message = 'Too many requests. Please slow down and try again.',
    super.stackTrace,
    super.statusCode = 429,
  });
}

/// Thrown when the server returns a 404 Not Found at the API level.
class ApiEndpointNotFoundException extends ServerException {
  /// Creates an API endpoint not found exception.
  const ApiEndpointNotFoundException({
    super.message = 'The requested API endpoint was not found.',
    super.stackTrace,
    super.statusCode = 404,
  });
}

/// Thrown when the server returns a 403 Forbidden.
class ForbiddenException extends ServerException {
  /// Creates a forbidden exception.
  const ForbiddenException({
    super.message = 'You do not have permission to access this resource.',
    super.stackTrace,
    super.statusCode = 403,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// CACHE / LOCAL STORAGE
// ─────────────────────────────────────────────────────────────────────────────

/// Base class for all local cache/storage exceptions.
class CacheException extends AppException {
  /// Creates a generic cache exception.
  const CacheException({required super.message, super.stackTrace});
}

/// Thrown when a cache read operation fails.
class CacheReadException extends CacheException {
  /// Creates a cache read exception.
  const CacheReadException({
    super.message = 'Failed to read data from local cache.',
    super.stackTrace,
  });
}

/// Thrown when a cache write operation fails.
class CacheWriteException extends CacheException {
  /// Creates a cache write exception.
  const CacheWriteException({
    super.message = 'Failed to write data to local cache.',
    super.stackTrace,
  });
}

/// Thrown when the requested key or entry is not present in the cache.
class CacheNotFoundException extends CacheException {
  /// Creates a cache not found exception.
  const CacheNotFoundException({
    super.message = 'Requested data was not found in local cache.',
    super.stackTrace,
  });
}

/// Thrown when cached data is corrupted or cannot be deserialized.
class CacheCorruptedException extends CacheException {
  /// Creates a cache corrupted exception.
  const CacheCorruptedException({
    super.message = 'Local cache data is corrupted.',
    super.stackTrace,
  });
}

/// Thrown when the local storage has no space left.
class CacheQuotaExceededException extends CacheException {
  /// Creates a cache quota exceeded exception.
  const CacheQuotaExceededException({
    super.message = 'Local storage quota exceeded. Please free up space.',
    super.stackTrace,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// STORAGE (FILE / MEDIA)
// ─────────────────────────────────────────────────────────────────────────────

/// Base class for all remote file storage exceptions.
class StorageException extends AppException {
  /// Creates a generic storage exception.
  const StorageException({required super.message, super.stackTrace});
}

/// Thrown when a file upload operation fails.
class UploadException extends StorageException {
  /// Creates an upload exception.
  const UploadException({
    super.message = 'File upload failed. Please try again.',
    super.stackTrace,
  });
}

/// Thrown when a file download operation fails.
class DownloadException extends StorageException {
  /// Creates a download exception.
  const DownloadException({
    super.message = 'File download failed. Please try again.',
    super.stackTrace,
  });
}

/// Thrown when the uploaded file exceeds the maximum allowed size.
class FileTooLargeException extends StorageException {
  /// Creates a file too large exception.
  const FileTooLargeException({
    super.message = 'File exceeds the maximum allowed size.',
    super.stackTrace,
    this.maxSizeBytes,
  });

  /// Maximum allowed size in bytes.
  final int? maxSizeBytes;

  @override
  List<Object?> get props => [message, stackTrace, maxSizeBytes];
}

/// Thrown when the file type/MIME type is not accepted.
class InvalidFileTypeException extends StorageException {
  /// Creates an invalid file type exception.
  const InvalidFileTypeException({
    super.message = 'File type is not allowed.',
    super.stackTrace,
    this.fileType,
  });

  /// The file type that was rejected.
  final String? fileType;

  @override
  List<Object?> get props => [message, stackTrace, fileType];
}

/// Thrown when the target storage bucket does not exist.
class BucketNotFoundException extends StorageException {
  /// Creates a bucket not found exception.
  const BucketNotFoundException({
    super.message = 'Storage bucket not found.',
    super.stackTrace,
  });
}

/// Thrown when trying to overwrite a file that already exists.
class FileAlreadyExistsException extends StorageException {
  /// Creates a file already exists exception.
  const FileAlreadyExistsException({
    super.message = 'A file with this name already exists.',
    super.stackTrace,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// VALIDATION
// ─────────────────────────────────────────────────────────────────────────────

/// Base class for all input validation exceptions.
class ValidationException extends AppException {
  /// Creates a generic validation exception.
  const ValidationException({
    required super.message,
    super.stackTrace,
    this.field,
  });

  /// The name of the field that failed validation, if applicable.
  final String? field;

  @override
  List<Object?> get props => [message, stackTrace, field];
}

/// Thrown when a required field is empty or null.
class RequiredFieldException extends ValidationException {
  /// Creates a required field exception.
  const RequiredFieldException({
    required super.field,
    super.message = 'This field is required.',
    super.stackTrace,
  });
}

/// Thrown when the value does not match the expected format
///  (e.g., invalid email).
class InvalidFormatException extends ValidationException {
  /// Creates an invalid format exception.
  const InvalidFormatException({
    required super.message,
    super.stackTrace,
    super.field,
  });
}

/// Thrown when the value length is outside the allowed range.
class LengthException extends ValidationException {
  /// Creates a length exception.
  const LengthException({
    required super.message,
    super.stackTrace,
    super.field,
    this.minLength,
    this.maxLength,
  });

  /// Minimum allowed length.
  final int? minLength;

  /// Maximum allowed length.
  final int? maxLength;

  @override
  List<Object?> get props => [message, stackTrace, field, minLength, maxLength];
}

/// Thrown when the value is outside the allowed numeric range.
class RangeException extends ValidationException {
  /// Creates a range exception.
  const RangeException({
    required super.message,
    super.stackTrace,
    super.field,
  });
}

/// Thrown when two values that must match do not (e.g., password confirmation).
class MismatchException extends ValidationException {
  /// Creates a mismatch exception.
  const MismatchException({
    super.message = 'The values do not match.',
    super.stackTrace,
    super.field,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// PARSING / SERIALIZATION
// ─────────────────────────────────────────────────────────────────────────────

/// Base class for all parsing and serialization exceptions.
class ParseException extends AppException {
  /// Creates a generic parse exception.
  const ParseException({required super.message, super.stackTrace});
}

/// Thrown when a JSON string cannot be decoded.
class JsonParseException extends ParseException {
  /// Creates a JSON parse exception.
  const JsonParseException({
    super.message = 'Failed to parse server response. Unexpected format.',
    super.stackTrace,
  });
}

/// Thrown when a value cannot be cast to the expected Dart type.
class TypeMismatchException extends ParseException {
  /// Creates a type mismatch exception.
  const TypeMismatchException({
    super.message = 'Unexpected data type received from the server.',
    super.stackTrace,
    this.expectedType,
    this.actualType,
  });

  /// The expected type.
  final String? expectedType;

  /// The actual type received.
  final String? actualType;

  @override
  List<Object?> get props => [message, stackTrace, expectedType, actualType];
}

/// Thrown when a required field is missing from the parsed data.
class MissingFieldException extends ParseException {
  /// Creates a missing field exception.
  const MissingFieldException({
    super.message = 'A required field is missing from the server response.',
    super.stackTrace,
    this.fieldName,
  });

  /// The name of the missing field.
  final String? fieldName;

  @override
  List<Object?> get props => [message, stackTrace, fieldName];
}

// ─────────────────────────────────────────────────────────────────────────────
// PERMISSION
// ─────────────────────────────────────────────────────────────────────────────

/// Base class for all permission-related exceptions.
class PermissionException extends AppException {
  /// Creates a generic permission exception.
  const PermissionException({required super.message, super.stackTrace});
}

/// Thrown when a required device permission (camera, location, etc.) is denied.
class DevicePermissionDeniedException extends PermissionException {
  /// Creates a device permission denied exception.
  const DevicePermissionDeniedException({
    super.message =
        'Permission denied. Please grant access in your device settings.',
    super.stackTrace,
    this.permissionName,
  });

  /// The name of the permission that was denied (e.g., 'camera', 'location').
  final String? permissionName;

  @override
  List<Object?> get props => [message, stackTrace, permissionName];
}

/// Thrown when the user permanently denied a device permission.
class DevicePermissionPermanentlyDeniedException extends PermissionException {
  /// Creates a device permission permanently denied exception.
  const DevicePermissionPermanentlyDeniedException({
    super.message = 'Permission permanently denied.'
        '\nPlease enable it in your device settings.',
    super.stackTrace,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// RESOURCE
// ─────────────────────────────────────────────────────────────────────────────

/// Thrown when a specific resource (record, file, user) cannot be found.
class NotFoundException extends AppException {
  /// Creates a not found exception.
  const NotFoundException({required super.message, super.stackTrace});
}

// ─────────────────────────────────────────────────────────────────────────────
// BUSINESS LOGIC
// ─────────────────────────────────────────────────────────────────────────────

/// Thrown when a business rule or domain constraint is violated.
class BusinessRuleException extends AppException {
  /// Creates a business rule exception.
  const BusinessRuleException({required super.message, super.stackTrace});
}

/// Thrown when the operation is not allowed in the current app state.
class InvalidOperationException extends AppException {
  /// Creates an invalid operation exception.
  const InvalidOperationException({required super.message, super.stackTrace});
}

// ─────────────────────────────────────────────────────────────────────────────
// UNKNOWN
// ─────────────────────────────────────────────────────────────────────────────

/// Thrown when the exception type cannot be determined.
class UnknownException extends AppException {
  /// Creates an unknown exception.
  const UnknownException({required super.message, super.stackTrace});
}

class RateLimitException implements Exception {
  const RateLimitException(this.message);
  final String message;

  @override
  String toString() => message;
}
