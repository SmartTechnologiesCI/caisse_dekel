page 70134 ListTransfert
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'Liste des transferts';
    UsageCategory = Lists;
    SourceTable = EntetTransfert;
    SourceTableView = where(valide = const(false));
    CardPageId = EnteteTransfert;


    layout
    {
        area(Content)
        {
            repeater(Général)
            {
                field(Caissier; Caissier)
                {
                    ApplicationArea = All;
                }
                field(Caisse; Caisse)
                {
                    ApplicationArea = All;
                }
                field(Solde; Solde)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        Transaction: Record Transactions;
                    begin
                        Transaction.SetFilter("user id", reC.Caissier);
                        if Transaction.FindSet() then begin
                            page.Run(page::"Liste des transactions", Transaction);
                        end;
                    end;
                }
                field(NumDocExtern; NumDocExtern)
                {
                    ApplicationArea = All;
                }
                field(Observation; Observation)
                {
                    ApplicationArea = All;
                }
                field(DateTransFert; DateTransFert)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }
}