page 70073 "Detail livraison"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Sales Invoice Line";
    Editable = false;


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;

                }
                //field("Nombre de carton"; rec."Nombre de carton") { Editable = false; }
                field("Carton effectif"; "Carton effectif") { Caption = 'Nombre de cartons'; Editable = false; }
                field(Description; Description) { }
                field(Quantity; Quantity)
                {
                    Caption = 'Poids';
                }
                field("Qté livrée"; "Qté livrée") { }
                field("Statut Livraison"; "Statut Livraison") { }
                field("Date Livraison"; "Date Livraison") { }

            }
        }
    }

    actions
    {
        area(Processing)
        {

            group("Livraison")
            {


                Caption = 'Effectuer une livraison';
                action(AjouterLivraison)
                {
                    Caption = 'Ajouter livraison';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;


                    trigger OnAction()
                    var
                    begin
                        Page.RunModal(70074, Rec);
                        CurrPage.Update();
                    end;

                }
            }
        }
    }


    var
        myInt: Integer;
}