page 70135 ListTransfertvalide
{
    PageType = List;
    Caption = 'Tansfert Validéss';
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;
    ModifyAllowed = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    SourceTable = EntetTransfert;
    SourceTableView = where(valide = const(true));
    CardPageId = EnteteTransfertValde;
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