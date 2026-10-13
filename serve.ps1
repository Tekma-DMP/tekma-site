$root = $PSScriptRoot
$types = @{ ".html"="text/html; charset=utf-8"; ".css"="text/css; charset=utf-8"; ".js"="application/javascript; charset=utf-8"; ".png"="image/png"; ".jpg"="image/jpeg"; ".svg"="image/svg+xml"; ".ico"="image/x-icon" }
$listener = [System.Net.HttpListener]::new()
$listener.Prefixes.Add("http://localhost:5610/")
$listener.Start()
Write-Host "Server started on http://localhost:5610/"
while ($true) {
  $ctx = $listener.GetContext()
  $local = [Uri]::UnescapeDataString($ctx.Request.Url.LocalPath)
  if ($local -eq "/") { $local = "/index.html" }
  $path = Join-Path $root ($local.TrimStart("/"))
  if (Test-Path $path -PathType Leaf) {
    $bytes = [System.IO.File]::ReadAllBytes($path)
    $ext = [System.IO.Path]::GetExtension($path).ToLower()
    if ($types.ContainsKey($ext)) { $ctx.Response.ContentType = $types[$ext] }
    $ctx.Response.ContentLength64 = $bytes.Length
    $ctx.Response.OutputStream.Write($bytes, 0, $bytes.Length)
  } else {
    $ctx.Response.StatusCode = 404
  }
  $ctx.Response.Close()
}
