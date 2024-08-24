tableextension 70001 "Customer Ext" extends Customer
{

    fields
    {
        field(70000; "Dépôts"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Depôt".Montant where("N° client" = field("No."), validated = const(true), isBonus = const(false)));
            Editable = false;
            FieldClass = FlowField;

        }
        field(70001; "Last credit date"; Date)
        {

        }
        field(70002; "Limit credit time"; Code[5])
        {

        }

        /* field(70003; "Total Facture Credit"; Decimal)
         {
             AutoFormatExpression = "Currency Code";
             AutoFormatType = 1;
             Editable = false;
             FieldClass = FlowField;
             CalcFormula = sum("Sales Invoice Header"."Remaining Amount" where(CreditP = const(true), "Sell-to Customer No." = field("No.")));
         }*/
        field(70004; Crédits; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;

            Editable = false;
        }
        field(70005; "do epargne"; Boolean)
        {
            DataClassification = ToBeClassified;


        }
        field(70006; "Montant prime bonus"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Depôt".Montant where("N° client" = field("No."), isBonus = const(true)));

        }
    }

    fieldgroups
    {
        addlast(DropDown; "Mobile Phone No.") { }
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        /*if name = '' then
            Error('Veuillez saisir le Nom du client');
        if Address = '' then
            Error('Veuillez saisir l''adresse du client');
        if "Phone No." = '' then
            Error('Veuillez saisir le téléphone du client');*/

    end;



    var
        myInt: Integer;
}