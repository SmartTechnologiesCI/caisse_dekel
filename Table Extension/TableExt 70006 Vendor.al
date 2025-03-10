tableextension 70006 "Vendor ext" extends Vendor
{
    fields
    {
        // Add changes to table fields here
        field(70000; "Total Achat"; Decimal)
        {

            FieldClass = FlowField;
            // CalcFormula = sum(Transactions."Montant NET" where(Source = const(Depot), date = field(dateFilter), "Code caisse" = const('CAISSE1')));
            // CalcFormula = sum("Purchase Line"."Amount Including VAT");

        }
    }

    var
        myInt: Integer;
}