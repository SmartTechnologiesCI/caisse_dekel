page 70000 Caisses
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Caisse;

    layout
    {
        area(Content)
        {
            repeater("Caisses")
            {
                field("Code"; "Code caisse")
                {
                    CaptionML = ENU = 'Code', FRA = 'Code';
                    ApplicationArea = All;
                }
                field("Nom caisse"; "Nom caisse")
                {
                    CaptionML = ENU = 'Name', FRA = 'Nom';
                }
                field(Compte; Compte)
                {
                    CaptionML = ENU = 'General account', FRA = 'Compte général';
                }
                field("User ID"; "User ID")
                {
                    CaptionML = ENU = 'User ID', FRA = 'Code utilisateur';
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
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}