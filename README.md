大致思路就是在cell被选中的时候设置一个selectIndexPath记录下来，在cell被取消选中的时候也用DeselectIndexPath记录下来，除了在cell被选中和取消选中的时候处理，还要在cell被赋值数据和cell即将出现的时候设置。
