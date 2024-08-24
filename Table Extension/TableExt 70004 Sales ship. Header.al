tableextension 70004 "Sales Ship. Header" extends 110
{
    fields
    {
        field(700010; "Invoice No."; code[30])
        {

        }
        field(70011; "Payment DateTime"; DateTime)
        {

        }
        field(70012; "Statut livraison"; Option)
        {
            OptionMembers = "Non payée","Non payée totalement livré","Non payée partiellement livré","Payée Non livré","Payée totalement livré","Payée partiellement livré";
        }
    }

    var
        myInt: Integer;
}