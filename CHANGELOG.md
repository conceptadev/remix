# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

## 2026-08-13

### Changes

---

Packages with breaking changes:

 - [`remix` - `v1.0.0-beta.5`](#remix---v100-beta5)

Packages with other changes:

 - [`remix_fortal` - `v0.1.0-beta.4`](#remix_fortal---v010-beta4)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `remix_fortal` - `v0.1.0-beta.4`

---

#### `remix` - `v1.0.0-beta.5`

 - **REFACTOR**: remove prism/prism_flutter dependency (#56).
 - **REFACTOR**: migrate components to mix annotations and code generation (#35).
 - **REFACTOR**: Update to Flutter 3.38.1 and mix 2.0.0-rc.0, refactor API usage (#24).
 - **FIX**(remix): forward Select mouse cursor (#142).
 - **FIX**(ci): keep git clean during publish by pre-declaring analysis_options excludes (#140).
 - **FIX**(remix): correct focus-visible state handling (#127).
 - **FIX**(remix): respect input modality for focus rings (#125).
 - **FIX**(remix): correct component accessibility and bounded layout (#79).
 - **FIX**(remix): make checkbox styles value-comparable (#124).
 - **FIX**(remix): forward toggle excludeSemantics (#123).
 - **FIX**: handle unbounded width constraints in RemixSelect (#31).
 - **FIX**(remix): center segmented control segment content (#112).
 - **FIX**(remix): data table review follow-ups (#111).
 - **FIX**(remix): clear stale textfield hover state on disable (#110).
 - **FIX**: add slider min/max validation and export StyledTextStyleMixin (#32).
 - **FIX**(accordion): set default content text color in Fortal styler (#73).
 - **FIX**(dialog): compose child with title, description, and actions (#64).
 - **FEAT**(remix): add textarea component (#107).
 - **FEAT**(remix): add segmented control component (#108).
 - **FEAT**: add iconAlignment (#29).
 - **FEAT**(remix): add checkbox group (#106).
 - **FEAT**(remix): add labeled checkbox contracts (#105).
 - **FEAT**(remix): add compound menu items with Radix-parity styling (#101).
 - **FEAT**(remix): add skeleton component (#104).
 - **FEAT**(remix): add data list component (#103).
 - **FEAT**(remix): expose canonical styler names for all components (#100).
 - **FEAT**(fortal): add recipes for new components (#113).
 - **FEAT**(fortal): align visuals with Radix Themes 3.3.0 (#80).
 - **FEAT**(fortal): add typography recipes (#126).
 - **FEAT**: rename button styler (#78).
 - **FEAT**: expose consistent factories across Remix stylers (#74).
 - **FEAT**(remix): add popover component (#76).
 - **FEAT**(remix): add toggle group (#75).
 - **FEAT**(remix): add toggle group (#71).
 - **FEAT**(remix): add alert dialog wrapper (#72).
 - **FEAT**(textfield): expose column wrapper as stylable ColumnBox (#69).
 - **FEAT**(remix): give the accordion a panel container (#133).
 - **FEAT**: add call() method to design system styles (#30).
 - **FEAT**: Add leading and trailing icon support to RemixButton (#20).
 - **FEAT**(remix): forward omitted semantic and behavioral parameters (#144).
 - **FEAT**(remix): add data table component (#109).
 - **FEAT**(remix): implement Mix generator migration (#55).
 - **FEAT**: add RemixToggle component (#50).
 - **FEAT**: add backgroundColor, foregroundColor, shape and factory methods to RemixCalloutStyle (#49).
 - **FEAT**: add factory constructors and shape to RemixCardStyle (#48).
 - **FEAT**: align component style APIs with Material conventions (#47).
 - **FEAT**: rename badge color to backgroundColor, add foregroundColor and factory constructors (#46).
 - **FEAT**: add convenience factory methods to RemixAccordionStyle (#44).
 - **FEAT**: add convenience methods and factory constructors to RemixAvatarStyle (#45).
 - **FEAT**: add Material-like style convenience methods to RemixButtonStyle (#43).
 - **FEAT**: Create FortalScope widget (#37).
 - **FEAT**(atlas): establish Fortal capture baseline (#67).
 - **DOCS**(remix): define host capability contract (#99).
 - **BREAKING** **REFACTOR**(remix): one spelling per styler operation (#132).
 - **BREAKING** **FEAT**(remix): customizable Select trigger indicator icons (#145).
 - **BREAKING** **FEAT**(remix): move Fortal into the new remix_fortal package (#114).
 - **BREAKING** **FEAT**(remix): remove direct Material usage from published packages (#134).
 - **BREAKING** **FEAT**: prepare Remix 1.0 release (#63).

