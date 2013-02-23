
gen_framework.sh

#!/bin/bash
if [ "$2" = "" ]
then
echo $0 "intf|impl some.def"
exit 0
fi
ACTION=$1
INPUT=$2
CLASS=${INPUT/.def/}
CLASS_NAME=`echo $CLASS|sed "s/_//g"`
CLASS_UPPER=`echo $CLASS|tr a-z A-Z `
CLASS_LOWER=`echo $CLASS|tr A-Z a-z`
function gen_h_begin()
{
	echo "#ifndef $CLASS_UPPER"$1"_H"
		echo "#define $CLASS_UPPER"$1"_H"
		echo ""
		echo "ME_DECLS_BEGIN"
		echo ""
		return;
}
function gen_h_end()
{
	echo "ME_DECLS_END"
		echo ""
		echo "#endif/*$CLASS_UPPER"$1"_H*/"
		echo ""
		return;
}
function gen_intf()
{
	echo "#include /"mobile_explorer_types.h/""
		gen_h_begin
		echo "struct _$CLASS_NAME;"
		echo "typedef struct _$CLASS_NAME $CLASS_NAME;"
		echo ""
		awk -F: '{
			Class=$3;gsub(/_/, "", Class);
			Func=$4;gsub(/_/, "", Func);
			print "typedef "$2" (*"Class Func"Func)("$5");";
		}' $INPUT
	echo "";
	echo "struct _$CLASS_NAME"
		echo "{"
		awk -F: '{
			Class=$3;gsub(/_/, "", Class);
			Func=$4;gsub(/_/, "", Func);
			print " " Class Func "Func " tolower($4)";";
		}' $INPUT
	echo ""
		echo "  char priv[0];"
		echo "};"
		echo ""

		awk -F: '{
			Class=$3;
			Func=$4;
			print "static inline "$2" "tolower(Class) "_" tolower(Func)"("$5")";
			print "{";
			if($2 != "void")
			{
				print " me_return_val_if_fail(thiz != NULL && thiz->"tolower(Func)" != NULL, ME_RET_PARAMS);";
			}
			else
			{
				print " me_return_if_fail(thiz != NULL && thiz->"tolower(Func)" != NULL);";
			}
			print "";
			if($2 != "void")
			{
				printf "    return ";
			}
			else
			{
				printf "    ";
			}
			printf "thiz->"tolower(Func)"(";
			system("./param_gen_call.sh " $5);
			print ");"
				if($2 != "void")
				{
				}
				else
				{
					print "";
					print " return;";
				}
			print "}/n"
		}' $INPUT
	gen_h_end
		return;
}
IMPL=$ACTION
IMPL_UPPER=`echo $IMPL|tr a-z A-Z`
IMPL_LOWER=`echo $IMPL|tr A-Z a-z`
function gen_impl_h
{
	echo "#include <$CLASS_LOWER.h>"
		gen_h_begin "_"$IMPL_UPPER
		echo "$CLASS_NAME* "$CLASS_LOWER"_"$IMPL_LOWER"_create();"
		gen_h_end "_"$IMPL_UPPER
		return;
}
function gen_impl_c
{
	echo "#include <"$CLASS_LOWER"_"$IMPL_LOWER".h>"
		echo ""
		echo "typedef struct _PrivInfo"
		echo "{"
		echo "  unsigned int dummy;"
		echo "}PrivInfo;"
		echo ""

		awk -v impl=$IMPL -F:   '{
			Class=$3;
			Func=$4;
			print "static "$2" "tolower(Class) "_"tolower(impl)"_"tolower(Func)"("$5")";
			print "{";
			if($2 != "void")
			{
				print " me_return_val_if_fail(thiz != NULL, ME_RET_PARAMS);";
			}
			else
			{
				print " me_return_if_fail(thiz != NULL);";
			}
			print ""
				print " PrivInfo* priv = (PrivInfo*)thiz->priv;"
				print ""
				if($2 != "void")
				{
					print " return ("$2 ")0;";
				}
				else
				{
					print " return;"; 
				}
			print "}/n"
		}' $INPUT
	echo ""
		echo "$CLASS_NAME* "$CLASS_LOWER"_"$IMPL_LOWER"_create()"
		echo "{"
		echo "  $CLASS_NAME* thiz = ($CLASS_NAME*)malloc(sizeof($CLASS_NAME) + sizeof(PrivInfo));"
		echo ""
		echo "  if(thiz != NULL)"
		echo "  {"
		awk -v impl=$IMPL -F:   '{
			Class=$3;
			Func=$4;
			print "     thiz->"tolower(Func)" = "tolower(Class) "_"tolower(impl)"_"tolower(Func)";";
		}' $INPUT
	echo "  }"
		echo ""
		echo "  return thiz;"
		echo "}"
		return;
}
if [ "$ACTION" = "intf" ]
then
echo "gen_intf >$CLASS_LOWER.h"
gen_intf >$CLASS_LOWER.h
else
echo "gen_impl_h >$CLASS_LOWER"_"$IMPL_LOWER.h"
gen_impl_h >$CLASS_LOWER"_"$IMPL_LOWER.h
echo "gen_impl_c >$CLASS_LOWER"_"$IMPL_LOWER.c"
gen_impl_c >$CLASS_LOWER"_"$IMPL_LOWER.c
fi


param_gen_call.sh

#!/bin/bash
echo $* |awk -F, '
{
	for(i = 1; i <= NF; i++) 
	{
		system("./param_gen_call_one.sh " $i);
		if(i != NF)
		{
			printf(", ");
		}
	}
}'

param_gen_call_one.sh

#!/bin/bash
echo $* |awk  '{printf $NF}'

~~end~~

