page 70024 "Ouverture SubForm"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Billiet ouverture";

    layout
    {
        area(Content)
        {
            repeater("Billets")
            {
                Caption = 'Liste des billets';

                field("Code Billet"; "Code Billet")
                {
                    ApplicationArea = All;
                }
                field("Qty."; "Qty.")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        billet: Record Billetage;
                    begin
                        billet.Get(rec."Code Billet");
                        rec.total := billet.Valeur * rec."Qty.";
                        // CalculerMontantTotal();
                    end;
                }
                field(total; Total)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                /*field(Start; Start)
                {
                    Editable = false;
                }*/
            }
        }
    }

    actions
    {

    }
}