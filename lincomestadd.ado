capture program drop lincomestadd
program define lincomestadd
syntax anything, statname(name) [format(string) omitstars]

capture which estadd
if _rc {
	di "You need to install estadd/estout first: ssc install estout."
	exit 199
}

lincom `anything'
local pvalue = 2*ttail(r(df), abs(r(estimate)/r(se)))
assert `pvalue' ~= .

if "`format'" == "" {
	local format %04.3f
}

local b : di `format' `r(estimate)'
local se : di `format' `r(se)'
local t : di `format' `r(estimate)'/`r(se)'
local bnum = `r(estimate)'
local senum = `r(se)'
local tnum = `r(estimate)'/`r(se)'

local stars ""
if "`omitstars'" == "" {
	if `pvalue' < 0.10 local stars *
	if `pvalue' < 0.05 local stars **
	if `pvalue' < 0.01 local stars ***
}

local bstring `b'`stars'
local sestring (`se')
local tstring `t'

estadd local `statname'b "`bstring'"
estadd local `statname'se "`sestring'"
estadd local `statname't "`tstring'"

estadd scalar `statname'b_num = `bnum'
estadd scalar `statname'se_num = `senum'
estadd scalar `statname't_num = `tnum'

end
