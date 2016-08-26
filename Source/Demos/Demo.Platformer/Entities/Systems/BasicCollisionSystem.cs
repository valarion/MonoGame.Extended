using System;
using Demo.Platformer.Entities.Components;
using Microsoft.Xna.Framework;
using MonoGame.Extended.Entities.Systems;
using MonoGame.Extended.Shapes;

namespace Demo.Platformer.Entities.Systems
{
    public class BasicCollisionSystem : UpdatableComponentSystem
    {
        private readonly RectangleF[] _collisionRectangles;

        public BasicCollisionSystem(RectangleF[] collisionRectangles)
        {
            _collisionRectangles = collisionRectangles;
        }

        public override void Update(GameTime gameTime)
        {
            var components = GetComponents<BasicCollisionComponent>();

            foreach (var c in components)
            {
                c.IsOnGround = false;

                foreach (var collisionRectangle in _collisionRectangles)
                {
                    var depth = c.BoundingRectangle.IntersectionDepth(collisionRectangle);

                    if (depth != Vector2.Zero)
                    {
                        var absDepthX = Math.Abs(depth.X);
                        var absDepthY = Math.Abs(depth.Y);

                        if (absDepthY < absDepthX)
                        {
                            c.Position += new Vector2(0, depth.Y); // move the player out of the ground or roof
                            c.IsOnGround = c.Velocity.Y > 0;

                            if (c.IsOnGround)
                                c.Velocity = new Vector2(c.Velocity.X, 0); // set y velocity to zero only if this is a ground collision
                        }
                        else
                        {
                            c.Position += new Vector2(depth.X, 0);  // move the player out of the wall
                            c.Velocity = new Vector2(c.Velocity.X, c.Velocity.Y < 0 ? 0 : c.Velocity.Y); // drop the player down if they hit a wall
                        }
                    }
                }
            }
        }
    }
}