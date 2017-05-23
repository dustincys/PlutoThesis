\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{plutothesis}[Harbin Institute of Technology Thesis Template]

\RequirePackage{kvoptions}
\SetupKeyvalOptions{
  family=pluto,
  prefix=pluto@,
  setkeys=\kvsetkeys}
\newif\ifpluto@bachelor % 定义一个布尔变量
\newif\ifpluto@master
\newif\ifpluto@doctor
\newif\ifpluto@postdoctor
\define@key{pluto}{type}{%
  \pluto@bachelorfalse %默认都是false
  \pluto@masterfalse
  \pluto@doctorfalse
  \pluto@postdoctorfalse
  \expandafter\csname pluto@#1true\endcsname} %含有选项的设为true

