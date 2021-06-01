# Error Codes and Warning Codes

When you make an API call to access an Agora SDK, the SDK may return error codes or warning codes: **Error codes are returned** when a problem that cannot be recovered without app intervention has occurred. **Warning codes are returned** when a problem that might be resolved automatically has occurred. Warning codes provide information but normally do not require any action.

This article provides descriptions and troubleshooting tips for common Agora SDK error and warning codes. If you receive a response that is not included here, Agora recommends you contact [support@agora.io] so that our technical support team can help resolve the issue.

<div class="alert note">An error code can be a negative number. In such a case, it should be read as if it were positive. For example, if the SDK returns error code <code>-2</code>, you should refer to 2 in the error code table<code></code>.</div>

The error and warning codes may be returned in the following ways:

- The return value of a method call, represented by a negative number. In such a case, it should be read as if it were positive.
- An [onError] or [onWarning] callback.