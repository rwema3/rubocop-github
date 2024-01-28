# GitHub/RailsRenderLiteral

tldr; `render` MUST be passed a string literal template path.

* When used in conjunction with `GitHub/RailsViewRenderPathsExist`, linters can ensure the target file exists on disk and would not crash rendering a missing template.
* Makes it easier for humans to trace callers of a template. Simply search for the full path of the target template to find **all** call sites.
