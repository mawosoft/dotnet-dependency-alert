# DotNet Dependency Alert

GitHub action to scan .NET solutions and projects for vulnerable, deprecated, or outdated package references. If any such top-level or transitive package is found, a **Dependency Alert** issue is created in the repository. Subsequent alerts are only created if new problems arise or the package references have changed.

## Usage

See [action.yml](action.yml) for a description of all available input parameters. With the default settings, the action restores and scans the solution or project in the current directory.

```yaml
on:
  schedule:
  - cron: '0 5 * * *'

jobs:
  Dependencies:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout
      uses: actions/checkout@v3
    - name: Check Dependencies
      uses: mawosoft/dotnet-dependency-alert@v1
```

## Example of a Dependency Alert Issue

Workflow [Dependency Check](#workflow-yaml-url) Run [#25](#workflow-run-url)

### New Dependency Problems (1/4)
<details open><summary>Top-level Packages</summary>

<ul><li><samp>FooLib <code>[netstandard2.0]</code><br>
FooLib.Tests <code>[net6.0]</code></li></ul></samp>
<table><tr>
<th>Package</th>
<th>Latest</th>
</tr>
<tr valign="top">
<td>BenchmarkDotNet 0.13.2</td>
<td>0.13.7</td>
</tr>
</table>

</details>

<details open><summary>Transitive Packages</summary>

<table><tr>
<th>Package</th>
<th>Latest</th>
<th>Vulnerable</th>
<th>Deprecated</th>
</tr>
<tr valign="top">
<td><details><summary>Newtonsoft.Json 9.0.1</summary>
<samp>BarApp.Tests <code>[net6.0]</code><br>
FooLib.Tests <code>[net6.0]</code></samp></details></td>
<td>13.0.3</td>
<td><a href="https://github.com/advisories/GHSA-5crp-9r3c-p9vr">High</a></td>
<td></td>
</tr>
<tr valign="top">
<td><details open><summary>System.Collections.Immutable 5.0.0</summary>
<samp>BarApp <code>[net48, net6.0]</code><br>
BarApp.Tests <code>[net48, net6.0]</code><br>
FooLib <code>[netstandard2.0]</code><br>
FooLib.Tests <code>[net6.0]</code></samp></details></td>
<td>7.0.0</td>
<td></td>
<td>Other,Legacy</td>
</tr>
<tr valign="top">
<td><details><summary>System.Runtime.CompilerServices.Unsafe 5.0.0</summary>
<samp>BarApp <code>[net48, net6.0]</code><br>
BarApp.Tests <code>[net48, net6.0]</code><br>
FooLib <code>[netstandard2.0]</code><br>
FooLib.Tests <code>[net6.0]</code></samp></details></td>
<td>6.0.0</td>
<td></td>
<td>Other,Legacy</td>
</tr>
<tr valign="top">
<td><details><summary>System.Security.AccessControl 5.0.0</summary>
<samp>BarApp <code>[net48]</code><br>
BarApp.Tests <code>[net48]</code><br>
FooLib <code>[netstandard2.0]</code></samp></details></td>
<td>6.0.0</td>
<td></td>
<td>Other,Legacy</td>
</tr>
</table>

</details>

### All Dependency Problems (4/7)
<details><summary>Top-level Packages</summary>

<table><tr>
<th>Package</th>
<th>Latest</th>
<th>Vulnerable</th>
<th>Deprecated</th>
</tr>
<td><details><summary>BenchmarkDotNet 0.13.2</summary>
<samp>FooLib <code>[netstandard2.0]</code><br>
FooLib.Tests <code>[net6.0]</code></samp></details></td>
<td>0.13.7</td>
<td></td>
<td></td>
</tr>
<tr valign="top">
<td><details><summary>coverlet.collector 3.1.2</summary>
<samp>BarApp.Tests <code>[net48, net6.0]</code><br>
FooLib.Tests <code>[net6.0]</code></samp></details></td>
<td>6.0.0</td>
<td></td>
<td></td>
</tr>
<tr valign="top">
<td><details><summary>Microsoft.Extensions.FileSystemGlobbing 5.0.0</summary>
<samp>BarApp <code>[net48]</code></samp></details></td>
<td>7.0.0</td>
<td></td>
<td>Other,Legacy</td>
</tr>
<tr valign="top">
<td><details><summary>System.Text.RegularExpressions 4.3.0</summary>
<samp>FooLib <code>[netstandard2.0]</code></samp></details></td>
<td>4.3.1</td>
<td><a href="https://github.com/advisories/GHSA-cmhx-cq75-c4mj">High</a></td>
<td></td>
</tr>
</table>

</details>

<details><summary>Transitive Packages</summary>

<table><tr>
<th>Package</th>
<th>Latest</th>
<th>Vulnerable</th>
<th>Deprecated</th>
</tr>
<tr valign="top">
<td><details><summary>Microsoft.Extensions.FileSystemGlobbing 5.0.0</summary>
<samp>BarApp.Tests <code>[net48]</code></samp></details></td>
<td>7.0.0</td>
<td></td>
<td>Other,Legacy</td>
</tr>
<tr valign="top">
<td><details><summary>Newtonsoft.Json 9.0.1</summary>
<samp>BarApp.Tests <code>[net6.0]</code><br>
FooLib.Tests <code>[net6.0]</code></samp></details></td>
<td>13.0.3</td>
<td><a href="https://github.com/advisories/GHSA-5crp-9r3c-p9vr">High</a></td>
<td></td>
</tr>
<tr valign="top">
<td><details><summary>System.Collections.Immutable 5.0.0</summary>
<samp>BarApp <code>[net48, net6.0]</code><br>
BarApp.Tests <code>[net48, net6.0]</code><br>
FooLib <code>[netstandard2.0]</code><br>
FooLib.Tests <code>[net6.0]</code></samp></details></td>
<td>7.0.0</td>
<td></td>
<td>Other,Legacy</td>
</tr>
<tr valign="top">
<td><details><summary>System.Net.Http 4.3.0</summary>
<samp>BarApp.Tests <code>[net6.0]</code><br>
FooLib.Tests <code>[net6.0]</code></samp></details></td>
<td>4.3.4</td>
<td><a href="https://github.com/advisories/GHSA-7jgj-8wvc-jh57">High</a></td>
<td></td>
</tr>
<tr valign="top">
<td><details><summary>System.Runtime.CompilerServices.Unsafe 5.0.0</summary>
<samp>BarApp <code>[net48, net6.0]</code><br>
BarApp.Tests <code>[net48, net6.0]</code><br>
FooLib <code>[netstandard2.0]</code><br>
FooLib.Tests <code>[net6.0]</code></samp></details></td>
<td>6.0.0</td>
<td></td>
<td>Other,Legacy</td>
</tr>
<tr valign="top">
<td><details><summary>System.Security.AccessControl 5.0.0</summary>
<samp>BarApp <code>[net48]</code><br>
BarApp.Tests <code>[net48]</code><br>
FooLib <code>[netstandard2.0]</code></samp></details></td>
<td>6.0.0</td>
<td></td>
<td>Other,Legacy</td>
</tr>
<tr valign="top">
<td><details><summary>System.Text.RegularExpressions 4.3.0</summary>
<samp>BarApp.Tests <code>[net6.0]</code><br>
FooLib.Tests <code>[net6.0]</code></samp></details></td>
<td>4.3.1</td>
<td><a href="https://github.com/advisories/GHSA-cmhx-cq75-c4mj">High</a></td>
<td></td>
</tr>
</table>

</details>

