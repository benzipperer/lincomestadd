{smcl}
{vieweralsosee "estadd" "help estadd"}{...}
{title:Title}

{phang}
{bf:lincomestadd} {hline 2} Use lincom, but add estimates to current e() results using estadd


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmd:lincomestadd} {it:{help exp}}, {opt statname(prefix)} [{it:options}]

{pstd}where {it:prefix} is the prefix of macros you will save into e().

{synoptset 30 tabbed}{...}
{marker table_options}{...}
{synopthdr:options}
{synoptline}
{syntab:Main}
{synopt:{opt format(%fmt)}}display format of strings{p_end}
{synopt:{opt nostars}}omit significance stars to strings{p_end}
{synoptline}

{marker description}{...}
{title:Description}

{pstd}
{cmd:lincomestadd} is just {cmd:lincom}, except that it also saves the output to e() stored results, instead of just r(). It does this by calling {cmd:estadd}.

{pstd}
It saves into e() the formatted strings

{p2colset 9 25 25 1}{...}
{p2col:e({it:prefix}b)}r(b){p_end}
{p2col:e({it:prefix}se)}r(se){p_end}
{p2col:e({it:prefix}df)}r(df){p_end}
{p2col:e({it:prefix}t)}associated t-statistic{p_end}

{pstd}
where the strings are formatted according to {format(%fmt)}}, with default %04.3f. It also includes significance stars on e({it:prefix}b) unless the option {opt nostars} is specified. Parentheses are placed around the standard error.

{pstd}
It also saves all of the non-formatted results as numeric values in e({it:prefix}stat_num). In addition, it also saves the {it:p}-value as numeric value in e({it:prefix}pvalue_num).

{pstd}
The formatted strings are particularly useful when making tables with e()-results.

{marker remarks}{...}
{title:Remarks}

{pstd}
This command requires the estadd package ({cmd:ssc install estadd}).

{marker examples}{...}
{title:Examples}

    {hline}
{pstd}Load some data and save lincom output to e() results{p_end}
{phang2}{cmd:. sysuse auto, clear}{p_end}
{phang2}{cmd:. reg price weight foreign}{p_end}
{phang2}{cmd:. lincomestadd price*1000, statname(price)}{p_end}
{phang2}{cmd:. lincomestadd price*1000 + foreign, statname(priceforeign)}{p_end}
{phang2}{cmd:. eststo model1}{p_end}

{pstd}Create a table with estout{p_end}
{phang2}{cmd:. esttab model1, cells(none) stats(priceb pricese blank priceforeignb priceforeignse, label("Price" " " " " "Price+Foreign" " " " ")) noabb}{p_end}
