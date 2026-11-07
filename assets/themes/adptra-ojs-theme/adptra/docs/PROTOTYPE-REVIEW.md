# Prototype alignment review

Requested reference:

`https://github.com/adptrawork/build-OJS/tree/main/docs/prototype`

## Access result

The prototype directory contents were not retrievable in the current build session. Direct access to the repository tree and the GitHub contents endpoint failed; the GitHub application connection was enabled, but no repository read action was exposed to this coding session. No screenshot, component source, design tokens, page inventory or asset was therefore available to inspect.

## Consequence

This build must not be represented as a pixel-accurate clone of the prototype. It uses a restrained academic/editorial visual language as a fallback and implements the OJS 3.3 data flow and administrative configurability described in the request.

## Closest OJS 3.3-native equivalents used

| Requested design/content area | Implemented OJS source / compromise |
|---|---|
| Journal identity/logo | OJS Website → Appearance logo, rendered by the inherited core header. |
| Hero/banner visual | OJS Homepage Image (`$homepageImage`) + Theme Options for eyebrow, title and description. |
| Navigation links | OJS Navigation Menus; no separate hard-coded nav list. |
| Search | Core OJS search route and query parameter. |
| Latest issue/articles | Current `$issue` and core `issue_toc.tpl`. |
| Featured articles | No fake featured records; OJS 3.3 has no native homepage curation field in the default index template. Current issue TOC is the safe nearest equivalent. |
| Announcements | OJS `$announcements` collection, controlled by the homepage announcement count. |
| Editorial board | Native About → Editorial Team route; names remain managed in OJS. |
| Views/downloads/citations | Core article/statistics plugins; no undocumented SQL or fabricated counts. |

Once the prototype directory or its exported assets are accessible, the CSS and component templates can be mapped against its actual spacing, typography, color tokens, breakpoints and page structure without changing the OJS data bindings.
