page 70031 "Ligne commande paiement"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = 113;
    Caption = 'Liste des articles';
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater("Liste des articles")
            {
                /* field("No."; "No.")
                 {
                     ApplicationArea = All;

                 }*/
                field(Description; rec.Description)
                {
                    ApplicationArea = All;

                }
                field("Carton effectif"; rec."Carton effectif")
                {

                    Style = Strong;
                    ApplicationArea = All;

                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = All;
                    DecimalPlaces = 0 : 3;

                }
                field("Unit Price"; rec."Unit Price")
                {
                    ApplicationArea = All;

                }
                field("Line Amount"; rec."Line Amount")
                {
                    Style = Strong;
                    ApplicationArea = All;

                }

                field("Prix unitaire HT"; Round((rec."Unit Price" / 1.015), 0.01, '='))
                {
                    ApplicationArea = All;
                    Visible = false;
                    trigger OnValidate()
                    var
                        myInt: Integer;

                    begin

                    end;
                }

                field("Montant HT"; Round((rec."Amount Including VAT" / 1.015), 1, '='))
                {
                    ApplicationArea = All;
                    Visible = false;
                    DecimalPlaces = 0 : 2;

                }


            }
        }
    }



}